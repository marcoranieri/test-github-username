require 'open-uri'
require 'nokogiri'

class GithubScraper

  def self.favourite_languages(username)
    url = "https://github.com/#{username.gsub(/[[:space:]]/, '')}?tab=repositories"

  begin
    doc = Nokogiri::HTML(open(url).read)
  rescue
    doc = nil
  end

    unless doc.nil?
      result = Hash.new(0)
      filter = 'span[itemprop="programmingLanguage"]'
      doc.search(filter).each{ |span| result[span.text.strip] += 1 }

      result
    else
      {}
    end

  end

end

# p GithubScraper.favourite_languages("a rth ur-lit tm")
# {"HTML"=>9, "Ruby"=>12, "Shell"=>1, "JavaScript"=>2, "CSS"=>4}
