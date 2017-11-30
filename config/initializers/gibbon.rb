Gibbon::Request.api_key = ENV['MAILCHIMP_API_KEY'] || 'be787f2e0c40fc74ec7289bd95a3e9a1'
Gibbon::Request.timeout = 15
Gibbon::Request.open_timeout = 15
Gibbon::Request.symbolize_keys = true
Gibbon::Request.debug = false
