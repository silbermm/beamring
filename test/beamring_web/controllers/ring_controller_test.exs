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
      assert redirected_to(conn) == second.url
    end

    @tag host: :last, action: :next
    test "redirects to the first host", %{conn: conn, all_hosts: all_hosts} do
      [first | _] = all_hosts
      assert redirected_to(conn) == first.url
    end
  end

  describe "previous" do
    setup :browse_to

    @tag host: :last, action: :previous
    test "redirects to the previous host", %{conn: conn, all_hosts: all_hosts} do
      [_, second | _] = Enum.reverse(all_hosts)
      assert redirected_to(conn) == second.url
    end

    @tag host: :first, action: :previous
    test "redirects to the last host", %{conn: conn, all_hosts: all_hosts} do
      last = List.last(all_hosts)
      assert redirected_to(conn) == last.url
    end
  end

  describe "not found" do
    @describetag host: "https://noexist.com"

    setup :browse_to

    @tag action: :previous
    test "when action is previous", %{conn: conn} do
      assert html_response(conn, 404)
    end

    @tag action: :next
    test "when action is next", %{conn: conn} do
      assert html_response(conn, 404)
    end
  end

  describe "invalid params" do
    @describetag host: nil

    setup :browse_to

    @tag action: :previous
    test "when action is previous", %{conn: conn} do
      assert html_response(conn, 400)
    end

    @tag action: :next
    test "when action is next", %{conn: conn} do
      assert html_response(conn, 400)
    end
  end

  def browse_to(%{host: :first, conn: conn, all_hosts: all, action: action}) do
    [first | _] = all

    conn =
      case action do
        :next -> get(conn, ~p"/next?host=#{first.url}")
        :previous -> get(conn, ~p"/previous?host=#{first.url}")
      end

    %{conn: conn}
  end

  def browse_to(%{host: :last, conn: conn, all_hosts: all, action: action}) do
    last = List.last(all)

    conn =
      case action do
        :next -> get(conn, ~p"/next?host=#{last.url}")
        :previous -> get(conn, ~p"/previous?host=#{last.url}")
      end

    %{conn: conn}
  end

  def browse_to(%{host: nil, conn: conn, action: action}) do
    conn =
      case action do
        :next -> get(conn, ~p"/next")
        :previous -> get(conn, ~p"/previous")
      end

    %{conn: conn}
  end

  def browse_to(%{host: hostname, conn: conn, action: action}) do
    conn =
      case action do
        :next -> get(conn, ~p"/next?host=#{hostname}")
        :previous -> get(conn, ~p"/previous?host=#{hostname}")
      end

    %{conn: conn}
  end
end
