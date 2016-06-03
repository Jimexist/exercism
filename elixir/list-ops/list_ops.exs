defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count_inner(l)
  end

  defp count_inner(l) when l == [] do
    0
  end

  defp count_inner(l) do
    [_|tail] = l
    1 + count_inner(tail)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse_inner(l, [])
  end

  defp reverse_inner(l, acc) when l == [] do
    acc
  end

  defp reverse_inner(l, acc) do
    [h|t] = l
    reverse_inner(t, [h|acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map_inner(l, f, []) |> reverse
  end

  defp map_inner(l, f, acc) when l == [] do
    acc
  end

  defp map_inner(l, f, acc) do
    [h|t] = l
    map_inner(t, f, [f.(h)|acc])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter_inner(l, f)
  end

  defp filter_inner(l, f) when l == [] do
    []
  end

  defp filter_inner(l, f) do
    [h|t] = l
    case f.(h) do
      true -> [h|filter_inner(t, f)]
      _ -> filter_inner(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce(l, acc, f) do
    reduce_inner(l, acc, f)
  end

  defp reduce_inner(l, acc, f) when l == [] do
    acc
  end

  defp reduce_inner(l, acc, f) do
    [h|t] = l
    reduce_inner(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    append_inner(reverse(a), b) |> reverse
  end

  defp append_inner(acc, b) when b == [] do
    acc
  end

  defp append_inner(acc, b) do
    [h|t] = b
    append_inner([h|acc], t)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], &append/2)
  end
end
