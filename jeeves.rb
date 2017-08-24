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
  url = 'http://localhost:9999/analyzer-api'
  content = { 'content' => question }
# HTTParty.post(url, :body => { :content => the_string }.to_json, :headers => headers)
  res = HTTParty.post(url, :body => content.to_json, :headers => headers)
  res.body
end
