json.array!(@users) do |user|
  json.extract! user, :username, :email, :first_name, :last_name, :salt, :hashed_password
  json.url user_url(user, format: :json)
end
