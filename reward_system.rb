# frozen_string_literal: true

require 'sinatra'
require_relative 'env'
require './file_processor'
require './row_processor'
require './company'
require './customer'
require './score_calculator'
require 'logger'

get '/' do
  'Hola! This is just a dummy URL.'
end

get '/scores' do
  content_type :json
  input_file = params[:file][:tempfile]
  company = FileProcessor.new(input_file).process
  company.final_scores.to_json
end
