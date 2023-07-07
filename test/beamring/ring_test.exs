defmodule Beamring.RingTest do
  use ExUnit.Case

  alias Beamring.Ring

  test "all/0" do
    all = Ring.all()
    refute Enum.empty?(all)
    assert length(all) == 2
  end

  test "next/1" do
    [first, second | _] = Ring.all()
    assert Ring.next(first.url) == second
  end

  test "next/1 from the last element" do
    all = Ring.all()
    [first | _] = all
    last = List.last(all)

    assert Ring.next(last.url) == first
  end

  test "previous/1" do
    [first, second | _] = Ring.all()
    assert Ring.previous(second.url) == first
  end

  test "previous/1 from the first element" do
    all = Ring.all()
    [first | _] = all
    last = List.last(all)

    assert Ring.previous(first.url) == last
  end
end
