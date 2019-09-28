class PagesController < ApplicationController
  def index
  end

  def create
    user     = FetchGithubApi.new(params[:username])
    top_lang = user.fetch_top_n_repos_languages
    info     = user.fetch_user_avatar_and_repos_url

    redirect_to show_path(top_lang, info)
  end

  def show
    @avatar = params["avatar"]
    @repos_url = params["repos_url"]
    @top_lang = from_params_to_hash(params["format"])
  end

  private

  def from_params_to_hash(string)
    string.gsub(/[{}:]/,'').split('&').map{|h| h1,h2 = h.split('='); {h1 => h2}}.reduce(:merge)
  end
end
