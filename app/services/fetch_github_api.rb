require 'open-uri'
require 'json'

class FetchGithubApi

  def initialize(username)
    @username = username.gsub(/[[:space:]]/, '')
    @url      = "https://api.github.com/users/#{@username}/repos"
    @repos    = JSON.parse(open(@url).read)
  rescue
    @repos = []
  end

  def fetch_repos_languages
    result = Hash.new(0)
    @repos.each do |repo|
      result[repo["language"]] += 1 unless repo["language"].nil?
    end

    result
  end

  def fetch_user_avatar_and_repos_url
    return {} if @repos.empty?

    {
      "avatar" => @repos.first["owner"]["avatar_url"],
      "repos_url" => @repos.first["owner"]["repos_url"]
    }
  end

end

# arthur = FetchGithubApi.new("   ar th ur-li ttm    ")
# p arthur.fetch_repos_languages
# p arthur.fetch_user_avatar_and_repos_url

# {"Ruby"=>18, "PHP"=>1, "JavaScript"=>1, "HTML"=>4, "CSS"=>1}
# {"avatar"=>"https://avatars1.githubusercontent.com/u/16685604?v=4", "repos_url"=>"https://api.github.com/users/arthur-littm/repos"}
