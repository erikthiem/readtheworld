# This script returns the average words per sentence in a body of text

require 'pragmatic_segmenter'

def averageWordsPerSentence(text)

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

    return average.round(3)

end
