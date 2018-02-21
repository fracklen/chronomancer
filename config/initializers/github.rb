Octokit.configure do |c|
  c.api_endpoint = "#{ENV["GITHUB_URL"]}/api/v3/"
end
