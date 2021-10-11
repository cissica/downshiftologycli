# frozen_string_literal: true

require "open-uri"
require "pry"
require "word_wrap"
require "word_wrap/core_ext"

# scraper is resposible for scraping the given website for information
class Scraper
  def self.scrape_blog_list
    unparsed_page = open("https://downshiftology.com/browse-recipes/")
    parsed_page = Nokogiri::HTML(unparsed_page)
    posts = parsed_page.css("div.archive-post.facet-post")
    recipe_posts = []

    posts.each do |post|
      title = post.css("h4.title").text
      url = post.css("a")[0].attributes["href"].value
      recipe_posts << title
      Blogs.create(title, url)
    end
  end

  def self.scrape_post(object)
    post_url = object.url
    unparsed_page = open(post_url)
    post = Nokogiri::HTML(unparsed_page)
    post_a = {}
    post.css("div.wprm-recipe-container").each do |content|
      # rubocop:disable Layout/LineLength
      post_a[:summary] = content.css("div.wprm-recipe-summary.wprm-block-text-normal span").text.gsub("Make sure to watch the video above!", "")
      post_a[:ingredients] = content.css("div.wprm-recipe-ingredient-group li.wprm-recipe-ingredient").text.gsub("*see notes below about using a larger turkey)", "")
      post_a[:recipe] = content.css("div.wprm-recipe-instruction-group ul.wprm-recipe-instructions").text
    end
    object.content(post_a)
    object.print
  end
end
