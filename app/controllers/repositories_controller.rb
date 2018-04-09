class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
          req.params['client_id'] = "REPLACE WITH STRING"
          req.params['client_secret'] = "REPLACE WITH STRING"
          req.params['q'] = params[:query]

      end

      body = JSON.parse(@resp.body)

      if @resp.success?
        @result = body['items']
      else

        @error = "Sorry, error with @resp."
      end

    rescue Faraday::ConnectionFailed
      @error = "There was a timeout. Please try again."
    end

    render 'search'
  end

end
