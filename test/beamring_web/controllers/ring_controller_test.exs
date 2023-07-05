defmodule BeamringWeb.RingControllerTest do
  use BeamringWeb.ConnCase, async: true

  alias Beamring.Ring

  setup do
    all_hosts = Ring.all()
    %{all_hosts: all_hosts}
  end

  describe "next" do
    setup :browse_to

    @tag host: :first, action: :next
    test "redirects to the next host", %{conn: conn, all_hosts: all_hosts} do
      [_, second | _] = all_hosts
      assert redirected_to(conn) == second
    end

    @tag host: :last, action: :next
    test "redirects to the first host", %{conn: conn, all_hosts: all_hosts} do
      [first | _] = all_hosts
      assert redirected_to(conn) == first
    end
  end

  describe "previous" do
    setup :browse_to

    @tag host: :last, action: :previous
    test "redirects to the previous host", %{conn: conn, all_hosts: all_hosts} do
      [_, second | _] = Enum.reverse(all_hosts)
      assert redirected_to(conn) == second
    end

    @tag host: :first, action: :previous
    test "redirects to the last host", %{conn: conn, all_hosts: all_hosts} do
      last = List.last(all_hosts)
      assert redirected_to(conn) == last
    end
  end

  def browse_to(%{host: :first, conn: conn, all_hosts: all, action: action}) do
    [first | _] = all

    conn =
      case action do
        :next -> get(conn, ~p"/next?host=#{first}")
        :previous -> get(conn, ~p"/previous?host=#{first}")
      end

    %{conn: conn}
  end

  def browse_to(%{host: :last, conn: conn, all_hosts: all, action: action}) do
    last = List.last(all)

    conn =
      case action do
        :next -> get(conn, ~p"/next?host=#{last}")
        :previous -> get(conn, ~p"/previous?host=#{last}")
      end

    %{conn: conn}
  end
end
