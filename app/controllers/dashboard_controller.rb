class DashboardController < ApplicationController
    before_action :authenticate_user!
    layout "authenticated_layout"

    def index
        @user = current_user
    end
    
end