require 'sinatra'

get '/' do
  erb :index
end

post '/analyze' do
  content_type :json
  freeling(params['question'])
end


private

require 'HTTParty'
require 'pp'

def freeling(question)
  headers = { 'content-type' => 'application/json' }
  url = 'http://localhost:9999/analyzer-api'
  content = { 'content' => question }
# HTTParty.post(url, :body => { :content => the_string }.to_json, :headers => headers)
  res = HTTParty.post(url, :body => content.to_json, :headers => headers)
  res.body
end
