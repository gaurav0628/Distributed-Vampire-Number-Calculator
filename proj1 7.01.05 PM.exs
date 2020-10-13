MyApp.start([],[])
values = System.argv()
{a, _} = Integer.parse(Enum.at(values, 0))
{b, _} = Integer.parse(Enum.at(values, 1))
if (a == 0 && b == 0) || b < a || a <= 0 || b <= 0, do: raise "Please enter valid input."
MyApp.DynamicSupervisor.start_all_task_workers(a,b)
