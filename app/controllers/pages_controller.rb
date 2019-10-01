class PagesController < ApplicationController

  def index
  end

  def create
    if params[:username].present?
      redirect_to show_path(params[:username])
    else
      redirect_to :root, alert: "Please insert a GitHub Username"
    end
  end

  def show
    user = fetch_user(params["format"])

    redirect_to_root unless user.repos.present?

    info_hash = user.fetch_username_avatar_url
    @top_lang = user.fetch_top_n_repos_languages

    # Rename "JS" for ShowPage Layout purpose
    if @top_lang.key? "JavaScript"
      @top_lang["JS"] = @top_lang.delete("JavaScript")
    end

    set_user(info_hash)
  end

private

  def fetch_user(username)
    FetchGithubApi.new(username)
  end

  def set_user(info)
    @avatar   = info["avatar"]
    @url      = info["url"]
    @username = info["username"]
  end

  def redirect_to_root
    redirect_to :root, alert: "USER NOT FOUND"; return
  end

end
