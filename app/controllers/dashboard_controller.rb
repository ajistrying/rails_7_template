class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user
    layout "authenticated_layout"

    def audiences
        case params[:audience_type]
        when "curated"
            @audience_type = "curated"
        when "custom"
            @audience_type = "custom"
        when "trending"
            @audience_type = "trending"
        else
            @audience_type = "curated"
        end
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