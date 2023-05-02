class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user
    layout "authenticated_layout"

    def audiences
        case params[:audience_type]
        when "curated"
            @audience_type = "curated"
            @curated_audiences = CuratedAudience.all
        when "custom"
            @audience_type = "custom"
            @custom_audiences = UserAudience.where(user: current_user)
        when "trending"
            @audience_type = "trending"
        else
            @audience_type = "curated"
            @curated_audiences = CuratedAudience.all
        end
    end

    def copy_audience
        curated_audience = CuratedAudience.find_by(name: params[:audience_name])
        new_audience = UserAudience.new(
            name: curated_audience.name,
            user: current_user,
            subscriber_count: curated_audience.subscriber_count,
            subreddit_names: curated_audience.subreddit_names,
            subreddit_icons: curated_audience.subreddit_icons,
        )

        if new_audience.save
            redirect_to audiences_path audience_type: "custom"
            flash[:notice] = "Audience copied successfully!"
        else
            redirect_to audiences_path audience_type: "curated", alert: "Something went wrong trying to copy that audience. Please try again."
        end
    rescue ActiveRecord::RecordNotUnique
        redirect_to audiences_path audience_type: "curated"
        flash[:alert] = "You've already copied that audience. Please try again."
    end

    def keyword_search
    end

    def discussions
    end

    def account
        case params[:page]
        when "subscription"
            @page = "subscription"
        when "notifications"
            @page = "notifications"
        else
            @page = "subscription"
        end
    end

    private

    def get_user
        @user = current_user
    end
    
end