defmodule PocUberauth.UserInfo do
  @enforce_keys [:login, :email]
  defstruct login: nil, email: nil, avatar_url: nil, orgs: []

  alias Ueberauth.Auth

  def user_info(auth = %Auth{}) do
    try do
      access_token = auth.extra.raw_info.token.access_token
      avatar_url = auth.extra.raw_info.user["avatar_url"]
      client = Tentacat.Client.new(%{access_token: access_token})
      login = auth.extra.raw_info.user["login"]
      emails = auth.extra.raw_info.user["emails"]

      email =
        List.first(
          Enum.flat_map(emails, fn
            %{"primary" => true} = email -> [email["email"]]
            _ -> []
          end)
        )

      {200, orgs, _} = Tentacat.Organizations.list_mine(client)
      orgs = Enum.reduce(orgs, [], fn %{"login" => org}, acc -> [org] ++ acc end)

      %__MODULE__{login: login, email: email, avatar_url: avatar_url, orgs: orgs}
    rescue
      error -> {:error, error}
    end
  end
end
