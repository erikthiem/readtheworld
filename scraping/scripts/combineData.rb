# This script combines all files in the data folder

require 'json'
require 'pp'

data_directory = "../data/"

data_hashes = []

# Get the data stored in each file
Dir[data_directory + "*"].each do |file|
    file_data = File.read(file)
    data_hash = JSON.parse(file_data)
    data_hashes << data_hash
end

all_articles = []

# Create a new combined data hash
data_hashes.each do |data_hash|
    data_hash.each do |article|
        all_articles << article
    end
end

#Write the combined data to a new file
File.open(data_directory + "combined.json", "w") do |f|
    f.write(all_articles.to_json)
end

