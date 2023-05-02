class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  has_many :user_audiences, dependent: :destroy

  # SUBSCRIPTION LIMITS
  FREE_CUSTOM_AUDIENCE_LIMIT = 3
  FREE_CONVERSATION_SEARCHES_LIMIT = 3

  STARTER_KEYWORD_SEARCH_LIMIT = 0
  STARTER_CUSTOM_AUDIENCE_LIMIT = 15
  STARTER_CONVERSATION_SEARCHES_LIMIT = 100
  STARTER_KEYWORD_TRACKING_ALERTS_LIMIT = 15

  PRO_KEYWORD_SEARCH_LIMIT = 0
  PRO_CUSTOM_AUDIENCE_LIMIT = 50
  PRO_CONVERSATION_SEARCHES_LIMIT = 200
  PRO_KEYWORD_TRACKING_ALERTS_LIMIT = 30
  PRO_AI_BRAINSTORM_MINUTES_LIMIT = 1000
end
