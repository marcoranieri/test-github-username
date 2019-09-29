require 'open-uri'
require 'json'

class FetchGithubApi
  attr_reader :repos

  def initialize(username)
    @username = username.gsub(/[[:space:]]/, '')
    @url      = "https://api.github.com/users/#{@username}/repos"
    @repos    = JSON.parse(open(@url).read)
  rescue
    @repos = []
  end

  def fetch_top_n_repos_languages(n=3)
    result = Hash.new(0)
    @repos.each do |repo|
      result[repo["language"]] += 1 unless repo["language"].nil?
    end

    result.sort_by {|a,b| -b}.first(n).to_h
  end

  def fetch_username_avatar_url
    return {} if @repos.empty?

    {
      "url"      => @repos.first["owner"]["html_url"],
      "avatar"   => @repos.first["owner"]["avatar_url"],
      "username" => @repos.first["owner"]["login"],
    }
  end

end

# arthur = FetchGithubApi.new("   ar th ur-li ttm    ")

# p arthur.fetch_top_n_repos_languages
# {"Ruby"=>18, "PHP"=>1, "JavaScript"=>1, "HTML"=>4, "CSS"=>1}

# p arthur.fetch_username_avatar_url
# {
#   "username"=>"marcoranieri",
#   "avatar"=>"https://avatars1.githubusercontent.com/u/16685604?v=4",
#   "repos_url"=>"https://api.github.com/users/arthur-littm/repos"
# }
