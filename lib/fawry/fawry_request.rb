# frozen_string_literal: true

module Fawry
  class FawryRequest
    DEFAULT_OPTIONS = { sandbox: false }.freeze

    attr_reader :action, :params, :request, :options

    def initialize(action, params, opts)
      @action = action
      @params = params
      @options = DEFAULT_OPTIONS.merge(opts)

      build_request
    end

    private

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/AbcSize
    def build_request
      case action
      when 'charge'
        self.class.include Requests::ChargeRequest
        validate_charge_params!
        @request = build_charge_request
      when 'refund'
        self.class.include Requests::RefundRequest
        validate_refund_params!
        @request = build_refund_request
      when 'payment_status'
        self.class.include Requests::PaymentStatusRequest
        validate_payment_status_params!
        @request = build_payment_status_request
      when 'create_card_token'
        self.class.include Requests::CreateCardTokenRequest
        validate_card_token_params!
        @request = build_create_card_token_request
      when 'list_tokens'
        self.class.include Requests::ListTokensRequest
        validate_list_tokens_params!
        @request = build_list_tokens_request
      when 'delete_token'
        self.class.include Requests::DeleteTokenRequest
        validate_delete_token_params!
        @request = build_delete_token_request
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
    end
  end
end
