json.array!(@roles) do |role|
  json.extract! role, :title
  json.url role_url(role, format: :json)
end
