defmodule Acronym do

  defp pluckChars(string) do
    first = string |> String.first
                   |> String.upcase
    rest = string |> String.slice(1..-1)
                  |> String.replace(~r/[^A-Z]/, "")
    Enum.join [first, rest]
  end

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
   string |> String.split
          |> Enum.map(&pluckChars/1)
          |> Enum.join
  end
end
