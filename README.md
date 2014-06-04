# auth-check-plugin

Sometimes you may want to talk to discourse and ask it if a username and password is a valid combination.

This plugin provides this route

```
GET /auth_check?u={username}&p={password}&token={token}
```

If the combo is valid, a `200` response is returned. Otherwise you get `403`

:warning: Before deploying, make sure to change the `TOKEN` constant in `auth_check.rb` to something of your choosing. It's purpose is to protect against malicious attempts to brute force valid username/password combinations, so do it!
