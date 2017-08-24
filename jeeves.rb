require 'sinatra'
require './lib/syntax'

get '/' do
  erb :index
end

get '/spongebob' do
  Syntax.spongebob
end

post '/analyze' do
  @raw_data = freeling(params['question'])
  erb :result
end


private

require 'HTTParty'
require 'pp'

def freeling(question)
  headers = { 'content-type' => 'application/json' }
  url = 'http://localhost:8000/dep'
  content = { 'text' => question, 'model' => 'en' }
  res = HTTParty.post(url, :body => content.to_json, :headers => headers)
  res.body
end
