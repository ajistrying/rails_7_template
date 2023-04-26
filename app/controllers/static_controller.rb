class StaticController < ApplicationController
  layout "static_layout"

  before_action :check_user

  def landing
  end

  def about
  end

  def pricing
  end
end
