require 'sinatra'

class Article

    def getText
        # TODO: Implement this
        "article text"
    end

    def getDifficulty
        # TODO: Implement this
        "article difficulty"
    end

end

get "/article/:id" do |id|
    # TODO: Implement this
    "Return article ##{params['id']}"
end
