# Jauthn

A demo Phoenix application to test FIDO2, WebAuthn using Wax library

## How to run the App

```bash
mix deps.get
cd assets && npm install && NODE_OPTIONS=--openssl-legacy-provider node node_modules/webpack/bin/webpack.js --mode development && cd ..
iex -S mix phx.server
```

and then browse [http://localhost:4000](http://localhost:4000)
