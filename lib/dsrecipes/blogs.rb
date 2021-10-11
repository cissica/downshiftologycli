# frozen_string_literal: true

require "pry"
require "word_wrap"

# Blogs class in resposible to creating, showing and saving Blog objects
class Blogs
  attr_accessor :title, :url, :summary, :ingredients, :recipe
  attr_reader :all

  @all = []

  def initialize(title:, url:)
    @title = title
    @url = url
    save
  end

  def save
    @all << self
  end

  def self.create(title, url)
    Blogs.new(title: title, url: url)
  end

  def content(post_hash)
    post_hash.each { |k, v| send("#{k}=", v) }
  end

  def print
    puts title.t_s
    puts "_______________________"
    puts ""
    puts summary.fit.to_s
    puts ""
    puts "Ingredients:\n#{ingredients.split(/(\d)/).join(",").gsub(",", "  ").fit}"
    puts ""
    puts "Recipe:\n#{recipe.fit}"
  end

  def self.find_by_number(number)
    @all[number]
  end

  def self.sorted
    @all.sort_by(title)
  end
end
