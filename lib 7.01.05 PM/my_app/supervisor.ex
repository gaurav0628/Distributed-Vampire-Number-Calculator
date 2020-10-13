defmodule MyApp.DynamicSupervisor do
  use DynamicSupervisor
  require Logger

  def start_link(arg) do
    DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    DynamicSupervisor.init(max_seconds: 30, strategy: :one_for_one)
  end

  def start_task_worker(task_id, numbers) do
    spec = {MyApp.TaskWorker, %{task_id: task_id}}
    {:ok, child} = DynamicSupervisor.start_child(__MODULE__, spec)
    GenServer.cast(child, {:start, numbers, self()})
  end

  def start_all_task_workers(a,b) do
    logical_processors = get_number_of_processors(b - a + 1)
    cores = div(b - a + 1, logical_processors)
    chunks = Enum.chunk_every(a..(b + 1), cores)
    for chunk <- chunks do
      start_task_worker(Enum.at(chunk, 0), chunk)
    end
    loop(logical_processors)
  end

  defp loop(count) do
    receive do
      {:put, list} ->
        IO.puts list
        loop(count)
      {:process_end} ->
        if count == 0 do
          Task.async(fn -> Process.exit(self(), :shutdown) end)
        else
          loop(count - 1)
        end
    end
  end

  defp get_number_of_processors(count_of_numbers) do
    if count_of_numbers < 6400 do
      count_of_numbers
    else
      :erlang.system_info(:logical_processors) * 200
    end
  end

end
