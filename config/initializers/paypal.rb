PAYPAL_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(
  :login     => "email@example.com", # change me
  :password  => "password", # change me
  :signature => "signature" # change me
)
