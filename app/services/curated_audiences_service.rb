class CuratedAudiencesService
    AUDIENCES = [
        {name: "Newsletters", subreddits: ["Newsletters", "Substack", "Emailmarketing"]},
        {name: "Pet Lovers", subreddits: ["cats", "dogs", "dogpictures", "pets", "lookatmydog", "pet", "petowners", "rats", "dogtraining"]},
        {name: "Gamers", subreddits: ["gaming", "linux_gaming", "pcgaming", "AndroidGaming", "battlestations", "Indiegaming"]},
        {name: "Travelers", subreddits: ["travel", "travelhacks", "solotravel", "shoestring", "onebag"]},
        {name: "Fashionistas", subreddits: ["malefashionadvice","femalefashionadvice","streetwear","fashion_design","fashion", "ethicalfashion", "vintagefashion"]},
        {name: "Parents", subreddits: ["parents", "parenting", "singleparents"]},
        {name: "Teachers", subreddits: ["teachers", "teaching", "askteachers", "scienceteachers"]},
        {name: "Entrepreneurs", subreddits: ["entrepreneurs", "startups", "entrepreneurridealong", "smallbusiness"]},
        {name: "Marketers", subreddits: ["marketing", "digitalmarketing", "digital_marketing", "content_marketing", "askmarketing", "instagrammarketing", "marketingporn", "socialmediamarketing", "marketingresearch", "marketingautomation", "contentmarketing"]},    
        {name: "Musicians", subreddits: ["musicians", "touringmusicians", "animemusicians", "classicalmusicians", "amateurmusicians"]},
        {name: "Photographers", subreddits: ["photographers", "virtualphotographers", "photography", "photocritique", "askphotography"]},
    ]
    class << self
        def run
            AUDIENCES.each do |audience|
                Rails.logger.info("RUNNING CuratedAudiencesService FOR #{audience[:name]}")
                curated_audience = CuratedAudience.find_by(name: audience[:name] )
                
                if curated_audience.nil?
                    
                    Rails.logger.info("CREATING NEW CURATED AUDIENCE: #{audience[:name]}")
                    curated_audience = CuratedAudience.create( name: audience[:name] )
                    
                    audience[:subreddits].each do |subreddit|
                        Rails.logger.info("UPDATING NEW CURATED AUDIENCE SUBREDDIT: #{subreddit}")
                        data = RedditApiService.get_subreddit_info(subreddit)

                        curated_audience.update(
                            subscriber_count: curated_audience.subscriber_count + data.dig("subreddit","subscribers")&.to_i || 0,
                            subreddit_count: curated_audience.subreddit_count + 1,
                            subreddit_names: curated_audience.subreddit_names.push(data.dig("subreddit","name")),
                            subreddit_icons: curated_audience.subreddit_icons.push(data.dig("subreddit","community_icon"))
                        )
                    end
                else
                    Rails.logger.info("UPDATING EXISTING CURATED AUDIENCE: #{audience[:name]}")
                    
                    audience[:subreddits].each do |subreddit|
                        Rails.logger.info("UPDATING EXISTING CURATED AUDIENCE SUBREDDIT: #{subreddit}")
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