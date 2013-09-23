json.array!(@companies) do |company|
  json.extract! company, :name, :website, :status
  json.url company_url(company, format: :json)
end
