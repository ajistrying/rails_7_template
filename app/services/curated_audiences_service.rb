class CuratedAudiencesService
    AUDIENCES = [
        {name: "Newsletters", subreddits: ["Newsletters","Substack","Emailmarketing"]}
    ]
    class << self
        def run
            AUDIENCES.each do |audience|
                curated_audience = CuratedAudience.find_by(name: audience[:name] )
                # binding.pry
                if curated_audience.nil?
                    
                    curated_audience = CuratedAudience.create( name: audience[:name] )
                    
                    audience[:subreddits].each do |subreddit|
                        data = RedditApiService.get_subreddit_info(subreddit)

                        curated_audience.update(
                            subscriber_count: curated_audience.subscriber_count + data.dig("subreddit","subscribers")&.to_i || 0,
                            subreddit_count: curated_audience.subreddit_count + 1,
                            subreddit_names: curated_audience.subreddit_names.push(data.dig("subreddit","name")),
                            subreddit_icons: curated_audience.subreddit_icons.push(data.dig("subreddit","community_icon"))
                        )
                    end
                else
                    audience[:subreddits].each do |subreddit|
                        data = RedditApiService.get_subreddit_info(subreddit)

                        next if curated_audience.subreddit_names.include?(subreddit)

                        curated_audience.update(
                            subscriber_count: curated_audience.subscriber_count + data.dig("subreddit","subscribers")&.to_i || 0,
                            subreddit_count: curated_audience.subreddit_count + 1,
                            subreddit_names: curated_audience.subreddit_names.push(data.dig("subreddit","name")),
                            subreddit_icons: curated_audience.subreddit_icons.push(data.dig("subreddit","community_icon"))
                        )
                    end
                end
            end
        end
    end
end