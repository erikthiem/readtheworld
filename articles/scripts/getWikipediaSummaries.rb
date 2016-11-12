require 'wikipedia'

# This script gets summaries from random wikipedia articles

# Search Spanish-language Wikipedia
Wikipedia.Configure {
    domain 'es.wikipedia.org'
}

number_of_articles = 10

articles = []

# Get the articles from Wikipedia
for i in 0..number_of_articles-1 do

    doc = Wikipedia.find_random()

    article = {}

	paragraphs = doc.summary.split("\n").reject { |s| s.empty? }

    article[:title] = doc.title
    article[:link] = doc.fullurl
    article[:body] = paragraphs
    articles << article
end

# Save the articles to a json file
File.open("../data/summaries_wikipedia.json", "w") do |f|
    f.write(articles.to_json)
end
