# frozen_string_literal: true

# rubocop:disable Layout/FirstHashElementIndentation
class Stripe::PaymentsService
  class << self
    include Rails.application.routes.url_helpers
    def create_checkout_session(inspection_request:)
      make_api_call do
        ### based on tier choice from buyer, generate the price id of rthe products we create within stripe

        # NOTE: FOR PROD: Ensure there are two price ids for tier one and tier two for automobiles FOR ARGUS Stripe account
        # NOTE: Figure out better system for tier choice
        price_id =  InspectionPackage.find(inspection_request.inspection_package_id)&.stripe_price_id

        ### Create checkout session for buyer
        session_obj = Stripe::Checkout::Session.create({
          line_items: [{ price: price_id, quantity: 1 }],
          mode: "payment",
          success_url: buyers_dashboard_url(redirect_option: "success", host: "localhost:3000"),
          cancel_url: edit_buyers_inspection_request_url(id: inspection_request.id, redirect_option: "failure", host: "localhost:3000"),
        })

        ### Return the session_obj so we can redirect the buyer to the checkout session with the contained generated url
        return ServiceResult.new(result: session_obj)
      end
    end

    private

    def make_api_call
      # NOTE: FOR PROD Enable dynamic changing key from dev to prod
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      yield
    rescue Stripe::CardError => _e
      # puts "Status is: #{e.http_status}"
      # puts "Type is: #{e.error.type}"
      # puts "Charge ID is: #{e.error.charge}"
      # # The following fields are optional
      # puts "Code is: #{e.error.code}" if e.error.code
      # puts "Decline code is: #{e.error.decline_code}" if e.error.decline_code
      # puts "Param is: #{e.error.param}" if e.error.param
      # puts "Message is: #{e.error.message}" if e.error.message
    rescue Stripe::RateLimitError => _e
      # Too many requests made to the API too quickly
      # NOTE: Log this error to Honeybadger
    rescue Stripe::InvalidRequestError => _e
      # Invalid parameters were supplied to Stripe's API

      Rails.logger.debug "Invalid Request Error"
      # NOTE: Log this error to Honeybadger
    rescue Stripe::AuthenticationError => _e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      # NOTE: Log this error to Honeybadger

      Rails.logger.debug "AuthenticationError"
    rescue Stripe::APIConnectionError => _e
      # Network communication with Stripe failed
      # NOTE: Log this error to Honeybadger

      Rails.logger.debug "APIConnectionError"
    rescue Stripe::StripeError => _e
      # Display a very generic error to the user, and maybe send
      # yourself an email

      Rails.logger.debug "StripeError"
    rescue => _e
      # Something else happened, completely unrelated to Stripe
    end
  end
end
# rubocop:enable Layout/FirstHashElementIndentation
