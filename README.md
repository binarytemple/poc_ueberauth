# PocUberauth


https://github.com/settings/applications/new

(create the app and add the tokens to your env i.e.

```
export POC_UBERAUTH_GITHUB_CLIENT_ID=<GITHUB_CLIENT_ID>
export POC_UBERAUTH_GITHUB_CLIENT_SECRET=<GITHUB_CLIENT_SECRET>
```

https://developer.github.com/apps/building-oauth-apps/creating-an-oauth-app/

https://developer.github.com/apps/building-oauth-apps/authorizing-oauth-apps/

iex -S mix phx.server

verify the tokens are good 

```
Application.get_all_env(:ueberauth)
```

localhost:4000/auth/github


----

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

