# auth-check-plugin

Sometimes you may want to talk to discourse and ask it if a username and password is a valid combination.

This plugin provides this route

```
GET /auth_check?u={username}&p={password}
```

If the combo is valid, a `200` response is returned. Otherwise you get `403`
