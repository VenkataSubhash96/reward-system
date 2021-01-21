# frozen_string_literal: true

require 'sinatra'
require './file_processor'
require './row_processor'
require './company'
require './customer'
require './score_calculator'
require 'logger'

get '/' do
  'Hola! This is just a dummy URL. <br /><br />Go to "/upload" to upload the input file and get scores'
end

get '/upload' do
  erb :upload_form
end

get '/scores' do
  content_type :json
  input_file = params[:file]
  company = FileProcessor.new(input_file).process
  company.final_scores.to_json
end
