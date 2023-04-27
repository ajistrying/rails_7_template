class ApplicationController < ActionController::Base
  layout "static_layout"

  def check_user
    redirect_to audiences_path if current_user
  end
  
end
