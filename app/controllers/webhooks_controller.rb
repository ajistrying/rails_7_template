# frozen_string_literal: true

class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { error: { message: e.message } }, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { error: { message: e.message, extra: "Sig verification failed" } }, status: :bad_request
      return
    end

    # NOTE: Enable this when going to prod to make sure we run functionality only on prod
    # If we're not in livemode
    # if !event.livemode
    #   p "Not in livemode!"
    #   return
    # end

    # Handle the event
    case event.type
    when "account.updated"
      account_updated_object = event.data.object
      Rails.logger.debug "Account Updated!: #{account_updated_object}"
    when "account.external_account.updated"
      external_account_updated_object = event.data.object
      Rails.logger.debug "External Account Updated!: #{external_account_updated_object}"
    when "payout.failed"
      payout_failed_object = event.data.object
      Rails.logger.debug "Payment Failed!: #{payout_failed_object}"
    when "payment_intent.succeeded"
      payment_intent_succeeded_object = event.data.object
      Rails.logger.debug "PaymentIntent was successful!: #{payment_intent_succeeded_object}"
    when "checkout.session.completed"
      cs_completed_object = event.data.object
      Rails.logger.debug "PaymentIntent was successful!: #{cs_completed_object}"
    when "checkout.session.async_payment_succeeded"
      csa_payment_succeeded_object = event.data.object
      Rails.logger.debug "PaymentIntent was successful!: #{csa_payment_succeeded_object}"
    when "checkout.session.async_payment_failed"
      csa_payment_failed_object = event.data.object
      Rails.logger.debug "PaymentIntent was successful!: #{csa_payment_failed_object}"
    else
      Rails.logger.debug "Unhandled event type: #{event.type}"
    end

    render json: { message: :success }
  end

  private

  def endpoint_secret
    ENV["STRIPE_ENDPOINT_SECRET"]
  end
end
