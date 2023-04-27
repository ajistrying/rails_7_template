# frozen_string_literal: true
require 'faraday'
require 'json'

class RedditApiService
    class << self
        def get_hot_posts
            make_api_call do |conn|
                subreddit = "blackpeopletwitter"
                response = conn.get("/hot", {name: subreddit})
                data = JSON.parse(response.body)
                puts data
            end
        end

        private

        def make_api_call(url, params)
            bearer_token = "4qsspcwhycqta5b6h4wc7pxtyg4qbw9fhca"

            conn = Faraday.new(
                url: 'http://127.0.0.1:5000',
                headers: {
                    'Content-Type' => 'application/json',
                    'Authorization' => "Bearer #{bearer_token}"
                }
            )
            yield conn
        end
    end
end