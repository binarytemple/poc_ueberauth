defmodule PocUberauth.UserAndOrgs do
  @enforce_keys [:login, :email]
  defstruct login: nil, email: nil, orgs: []

  alias Ueberauth.Auth

  def user_and_orgs_from_auth(auth = %Auth{}) do
    try do
      access_token = auth.extra.raw_info.token.access_token
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

      %__MODULE__{login: login, email: email, orgs: orgs}
    rescue
      error -> {:error, error}
    end
  end
end
