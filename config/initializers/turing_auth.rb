TuringAuth.admin_token = ENV["TURING_AUTH_ADMIN_TOKEN"]
TuringAuth.client_id = ENV['JOBS_GITHUB_ID']
TuringAuth.client_secret = ENV['JOBS_GITHUB_SECRET']
TuringAuth.init! #init omniauth extensions
