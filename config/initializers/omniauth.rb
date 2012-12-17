Rails.application.config.middleware.use OmniAuth::Builder do
    require 'openid/store/filesystem'
    provider :openid, :store => OpenID::Store::Filesystem.new('/tmp')
end
