defmodule MrT do
  def start(_, _) do
    case Mix.env do
      :dev  -> doit()
      :test -> doit()
      _     -> IO.write :stderr, "MrT NOT stared. Only :dev, :test environments are supported.\n"
    end
    {:ok, self}
  end

  def doit do
    ensure_event_bus_running
    ensure_watchers_running
    MrT.Quotes.quote_of_day
  end

  def start do
    Application.ensure_all_started(:mr_t)
  end

  def stop do
    Application.stop(:exfswatch)
    Application.stop(:mr_t)
    MrT.Quotes.bye
  end

  def run_all do
    test_runner.run_all
  end

  def run_matching(file) when is_binary(file) do
    run_matching([file])
  end

  def run_matching(files) when is_list(files) do
    test_runner.run_matching(files)
  end

  def test_runner do
    Application.get_env(:mr_t, :test_runner, MrT.Runner.ExUnit)
  end

  def test_runner_strategy do
    Application.get_env(:mr_t, :test_runner_strategy, MrT.RunStrategy.RootName)
  end

  def watchers(:dev) do
    [MrT.Monitor.Src]
  end

  def watchers(:test) do
    watchers(:dev) ++ [MrT.Monitor.Test]
  end

  defp ensure_watchers_running do
    watchers(Mix.env) |> Enum.each(fn(m)-> m.start end)
  end

  defp ensure_event_bus_running do
    MrT.EventBus.start
  end
end
