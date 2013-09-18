# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Dbauth::Application.config.secret_key_base = '36e6c96d5fc65c2ac4803f094367799a652fc6d857212303461709663360666b90159af2220509eb8f1b1cb6e120aa69fab8d95962372dbf9f3acf23f6f11bc5'
