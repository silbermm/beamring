defmodule Beamring.Repo do
  use Ecto.Repo,
    otp_app: :beamring,
    adapter: Ecto.Adapters.SQLite3
end
