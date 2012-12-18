Rails.application.config.middleware.use OmniAuth::Builder do
    require 'openid/store/filesystem'
    provider :openid, :store => OpenID::Store::Filesystem.new(Rails.root.join('tmp').to_s)
end
