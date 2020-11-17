require "pry"
require "word_wrap"

class Blogs
attr_accessor :title, :url, :summary, :ingredients, :recipe
@@all = []
    def initialize(title:, url:)
        @title = title 
        @url = url
        save
    end 

    def save 
        @@all << self 
    end     

    def self.create(title,url)
        n = Blogs.new(title: title, url: url)
    end 

    def content(post_hash)
        content = post_hash.each{|k,v| self.send(("#{k}="),v)}    
    end 

    def print
        puts "#{self.title}"
        puts ""
        puts "#{self.summary.fit}"
        puts ""
        puts "Ingredients: 
#{self.ingredients.fit}"
        puts ""
        puts "Recipe: 
#{self.recipe.fit}"
    end 

    def self.find_by_number(number)
        self.all[number]
    end 

    def self.all
        @@all
    end 
end