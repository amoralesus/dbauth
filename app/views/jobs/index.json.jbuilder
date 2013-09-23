json.array!(@jobs) do |job|
  json.extract! job, :title, :person_id, :company_id, :start_date, :end_date, :work_phone, :work_email
  json.url job_url(job, format: :json)
end
