require 'sinatra'

get "/" do
    erb :index
end

get "/article/:id" do |id|
    # TODO: Implement this
    "Return article ##{params['id']}"
end
