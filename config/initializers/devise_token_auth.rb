DeviseTokenAuth.setup do |config|
  config.default_confirm_success_url = "confirmed"
  config.change_headers_on_each_request = false
  config.headers_names = {:'access-token' => 'access-token',
                         :'client' => 'client',
                         :'expiry' => 'expiry',
                         :'uid' => 'uid',
                         :'token-type' => 'token-type' }
  config.enable_standard_devise_support = true
end
