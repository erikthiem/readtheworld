# This script gets reading level difficulty metrics for articles

require 'json'
require 'pragmatic_segmenter'
require 'pp'

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

    # Metric: Get average sentence length
    separator = PragmaticSegmenter::Segmenter.new(text: text, language: 'es')
    sentences = separator.segment

    sum = 0.0
    sentences.each do |sentence|
        sentence_length = sentence.split(" ").length
        sum += sentence_length
    end

    number_of_sentences = sentences.length

    if (number_of_sentences == 0)
        average = 0
    else
        average = sum / number_of_sentences
    end

    metrics[:average_sentence_length] = average.round(3)

    article[:metrics] = metrics

end

# Write the updated data to a new file
File.open(data_directory + output_file, "w") do |f|
    f.write(articles.to_json)
end

