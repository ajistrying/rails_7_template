class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :get_user
    layout "authenticated_layout"

    def audiences
    end

    def keyword_search
    end

    def discussions
    end

    def account
    end

    private

    def get_user
        @user = current_user
    end
    
end