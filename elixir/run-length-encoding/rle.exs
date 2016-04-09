defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string |> encode_inner([])
           |> Enum.join
  end

  defp to_result(tuple) do
    {count, c} = tuple
    [Integer.to_string(count), c]
  end

  defp from_result(tuple) do
    [count, c] = tuple
    String.duplicate c, String.to_integer(count)
  end

  defp encode_inner(string, acc) when string == "" do
    acc |> Enum.reverse
        |> Enum.flat_map(&to_result/1)
  end

  defp encode_inner(string, acc) do
    {first, tail} = String.split_at string, 1
    new_acc = case acc do
      [{count, ^first} | rest] -> [{count + 1, first} | rest]
      _ -> [{1, first} | acc]
    end
    encode_inner tail, new_acc
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string |> String.replace(~r/(\d+)(\w)/, "\\1 \\2 ")
           |> String.split
           |> Enum.chunk(2)
           |> Enum.map(&from_result/1)
           |> Enum.join
  end
end
