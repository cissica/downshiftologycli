# frozen_string_literal: true

require "pry"
require "word_wrap"

# cli class is responsible for displaying infromation to the user
class DownshiftologyCli
  # cli class is responsible for displaying infromation to the user
  class CLI
    def call
      puts "Welcome to some of Lisa's most popular recipes!"
      Scraper.scrape_blog_list
      options
    end

    def options
      puts "To discover some delicious recipes enter 'yum'"
      puts "To exit, enter 'exit'"
      input = gets.strip.downcase
      case input
      when "yum"
        blogs
        options
      when "exit"
        exit_program
      else
        invalid_entry
      end
    end

    def invalid_entry
      puts "Invalid Entry, try again."
      options
    end

    def blogs
      Blogs.all.each.with_index(1) do |blog, index|
        puts "#{index}. #{blog.title}"
      end
      puts "Which recipe is calling you? Enter the number."
      input = gets.to_i - 1
      input > 11 || /\D/.match?(input.to_s) ? invalid_entry : blog_info(input)
    end

    def blog_info(blog)
      b = Blogs.find_by_number(blog)
      if b.ingredients.nil?
        Scraper.scrape_post(b)
      else
        b.print
      end
    end

    def exit_program
      puts "Happy cooking! Comeback soon."
      exit
    end
  end
end
