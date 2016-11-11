# A script to download articles from El Pais newspaper to use as source material
# This is only to get some starter material before I think of a better way to get sources...

require 'open-uri'
require 'nokogiri'

# El Pais XML Feeds
elpais_frontpage_xml = "http://ep00.epimg.net/rss/elpais/portada.xml"
elpais_opinion_xml = "http://ep00.epimg.net/rss/elpais/opinion.xml"
elpais_art_xml = "http://elpais.com/tag/rss/arte/a/"
elpais_education_xml = "http://elpais.com/tag/rss/educacion/a/"
elpais_health_xml = "http://elpais.com/tag/rss/salud/a/"
elpais_technology_xml = "http://ep00.epimg.net/rss/tecnologia/portada.xml"

#elpais_xml_feeds = [elpais_frontpage_xml, elpais_opinion_xml, elpais_art_xml,
#                    elpais_education_xml, elpais_health_xml, 
#                    elpais_technology_xml]
elpais_xml_feeds = [elpais_frontpage_xml]


# Get links to all articles in these feeds
links = []

elpais_xml_feeds.each do |feed_url|
    doc = Nokogiri::XML(open(feed_url))

    # Get each item in the feed
    doc.xpath("//item/link").each do |link|
        links << link.text
    end
end

# Download the articles
articles = []
article_class = ".articulo__envoltorio"

links.each do |link|

    paragraphs = []

    doc = Nokogiri::HTML(open(link))
    article_text = doc.css(article_class).css("p").each do |paragraph|
        paragraphs << paragraph.text
    end
    articles << paragraphs
end
