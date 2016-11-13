# This script clears the data folder
# This is useful if the data format changes (with updates to the scraping scripts) and the old data needs to be discarded

require 'fileutils'

data_directory = "../data/"

puts "Are you sure you want to clear the data folder? (Y/N)"
response = gets.chomp

if (response.downcase == "y")
    puts "Clearing"
    FileUtils.rm_rf("#{data_directory}/.", secure: true) 
    puts "Done"
end


