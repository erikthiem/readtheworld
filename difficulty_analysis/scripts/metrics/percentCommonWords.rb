# This script returns the percent of words in a body of text that are 'common words'

require 'pragmatic_segmenter'

def percentCommonWords(text)

    words = text.split(/\W+/)

    commonWords = []

    File.readlines('commonWords_es_2000.txt').each do |commonWord|
        commonWords << commonWord.chomp
    end  

    commonWordCount = 0.0
    totalWordCount = 0

    words.each do |word|

        if commonWords.include?(word.downcase)
            
            commonWordCount += 1
        end

        totalWordCount += 1
        
    end

    if totalWordCount > 0
        percentCommon = ((commonWordCount * 100) / totalWordCount).round(3)
    else
        percentCommon = 0.000
    end

    return percentCommon

end
