defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    grouped = sentence |> String.replace(~r/[_:^!#@&,$%]+/, " ")
                       |> String.downcase
                       |> String.split
                       |> Enum.group_by(&(&1))
    for {k, v} <- grouped, into: %{}, do: {k, Enum.count(v)}
  end
end
