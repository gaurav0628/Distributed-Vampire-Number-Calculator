defmodule MyApp.TaskWorker do

  use GenServer, restart: :transient
  require Logger

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def init(name) do
    {:ok, name}
  end

  def handle_cast({:start, numbers, from}, state) do
    for number <- numbers do
      list = get_vampire_fangs(number)
      if length(list) > 0 do
        result = "#{number} " <> Enum.join(List.flatten(list), " ")
        send(from, {:put, "#{result}"})
      end
    end
    send(from, {:process_end})
    {:noreply, state}
  end

  defp get_number_len(number) do
    length(to_charlist(number))
  end

  defp get_factor_pairs(number) do
    number_length = get_number_len(number)
    half_length = :math.pow(10, div(number_length, 2))
    start_index = trunc(number / half_length)
    end_index = round(:math.sqrt(number))
    for i <- start_index..end_index, rem(number, i) == 0, do: [i, div(number, i)]
  end

  defp get_vampire_fangs(number) do
    if rem(get_number_len(number), 2) == 1 do
      []
    else
      all_characters_of_number = String.codepoints(to_string(number))
      needed_length = div(get_number_len(number), 2)
      pairs = get_factor_pairs(number)
      Enum.filter(
        pairs,
        fn [k, v] -> validate_pair(k, v, all_characters_of_number, needed_length) end
      )
    end
  end

  defp validate_pair(k, v, all_characters_of_number, needed_length) do
    if get_number_len(k) == needed_length && get_number_len(v) == needed_length && !has_trailing_zeros(k, v) do
      all_chars_from_pair = String.codepoints(to_string(k)) ++ String.codepoints(to_string(v))
      list = all_characters_of_number -- all_chars_from_pair
      if length(list) == 0 do
        true
      end
    end
  end

  defp has_trailing_zeros(number1, number2) do
    if rem(number1, 10) == 0 && rem(number2, 10) == 0 do
      true
    end
  end

end