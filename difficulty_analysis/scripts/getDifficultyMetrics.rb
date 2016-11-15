# This script gets reading level difficulty metrics for articles

require_relative("metrics/averageWordsPerSentence")

require 'json'
require 'pragmatic_segmenter'

data_directory = "../data/"
input_file = "unparsed.json"
output_file = "withdifficultydata.json"

data_hashes = []

# Get the articles
articles = JSON.parse(File.read(data_directory + input_file))

num_articles = articles.length
counter = 0

articles.each do |article|
    counter += 1
    puts "processed article #{counter} of #{num_articles}" 

    # Analyze the body text as one big text, not separate paragraphs
    text = article["body"].join(" ")

    metrics = {}

    # Metric: Get average words per sentence
    metrics[:average_sentence_length] = averageWordsPerSentence(text)

    article[:metrics] = metrics

end

# Write the updated data to a new file
File.open(data_directory + output_file, "w") do |f|
    f.write(articles.to_json)
end

