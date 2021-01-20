# frozen_string_literal: true

class RewardSystem < Sinatra::Base
  get '/' do
    'Hola! This is just a dummy URL.'
  end

  post '/invite_customer' do
    content_type :json
    input_file = params[:file][:tempfile]
    company = FileProcessor.new(input_file).process
    company.final_scores.to_json
  end
end
