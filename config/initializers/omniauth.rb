Rails.application.config.middleware.use OmniAuth::Builder do
    require 'openid/store/filesystem'
    #provider :openid, :store => OpenID::Store::Filesystem.new(Rails.root.join('tmp').to_s), name: 'google', :identifier => 'https://www.google.com/accounts/o8/id'
    provider :openid, :store => OpenID::Store::Filesystem.new(Rails.root.join('tmp').to_s), name: 'bugzilla', :identifier => 'http://www.novell.com/openid/user/id'
end
