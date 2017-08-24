require 'sinatra'
require './lib/syntax'

get '/' do
  erb :index
end

get '/spongebob' do
  Syntax.spongebob
end

post '/analyze' do
  @raw_data = spacy(params['question'])
  @arc_words = arc_words(@raw_data)
  erb :result
end


private

require 'HTTParty'
require 'pp'

def spacy(question)
  headers = { 'content-type' => 'application/json' }
  url = 'http://localhost:8000/dep'
  content = { 'text' => question, 'model' => 'en' }
  res = HTTParty.post(url, :body => content.to_json, :headers => headers)
  res.body
end

def arc_words(dep_res)
  response = JSON.parse(dep_res)
  relations = []
  for arc in response['arcs']
    relations << {
      start_word: response['words'][arc['start']],
      end_word: response['words'][arc['end']],
    }
  end

  relations
end
