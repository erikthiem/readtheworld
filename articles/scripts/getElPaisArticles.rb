# A script to download articles from El Pais newspaper to use as source material
# This is only to get some starter material before I think of a better way to get sources...

require 'open-uri'
require 'nokogiri'
require 'json'

# El Pais XML Feeds
elpais_frontpage_xml = "http://ep00.epimg.net/rss/elpais/portada.xml"
elpais_opinion_xml = "http://ep00.epimg.net/rss/elpais/opinion.xml"
elpais_art_xml = "http://elpais.com/tag/rss/arte/a/"
elpais_education_xml = "http://elpais.com/tag/rss/educacion/a/"
elpais_health_xml = "http://elpais.com/tag/rss/salud/a/"
elpais_technology_xml = "http://ep00.epimg.net/rss/tecnologia/portada.xml"

elpais_xml_feeds = [elpais_frontpage_xml, elpais_opinion_xml, elpais_art_xml,
                    elpais_education_xml, elpais_health_xml, 
                    elpais_technology_xml]


# Get links to all articles in these feeds
links = []

elpais_xml_feeds.each do |feed_url|
    begin
        doc = Nokogiri::XML(open(feed_url))
    rescue
        puts "Could not process article at link #{link}. Moving on to the next article."
    else
        # Get each item in the feed
        doc.xpath("//item/link").each do |link|
            links << link.text
        end
    end
end

# Download the articles
articles = []
article_class = "#articulo_contenedor"

links.each do |link|

    begin

        article = {}
        paragraphs = []
        doc = Nokogiri::HTML(open(link))

    rescue

        puts "Could not process article at link #{link}. Moving on to the next article."

    else

        article_title = doc.css("#articulo-titulo").text

        doc.css(article_class).css("p").each do |paragraph|
            paragraphs << paragraph.text
        end

        article[:title] = article_title
        article[:body] = paragraphs

        articles << article

    end
end

# Save the articles to a json file
File.open("../data/articles_elpais.json", "w") do |f|
    f.write(articles.to_json)
end 
