# frozen_string_literal: true
require 'faraday'
require 'json'

class RedditApiService
    class << self
        def get_hot_posts_from(subreddit)
            make_api_call do |conn|
                response = conn.get("/hot", {name: subreddit})
                data = JSON.parse(response.body)
                puts data
            end
        end

        def search_subreddit(subreddit, query)
            Rails.cache.fetch("subreddit_search_#{subreddit}_#{query}", expires_in: 5.minutes) do
                make_api_call do |conn|
                    response = conn.post("/search") do |req|
                        req.body = {name: subreddit, query: query}.to_json
                    end
                    data = JSON.parse(response.body)
                    data
                end
            end
        end

        def get_trending_subreddits
            make_api_call do |conn|
                response = conn.get("/trending")
                data = JSON.parse(response.body)
                puts data
            end
        end

        def get_subreddit_info(subreddit)
            Rails.cache.fetch("subreddit_info_#{subreddit}", expires_in: 10.minutes) do
                make_api_call do |conn|
                    response = conn.get("/subreddit", {name: subreddit})
                    data = JSON.parse(response.body)
                    data
                end
            end
        end

        private

        def make_api_call
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