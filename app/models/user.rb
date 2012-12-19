class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
  has_many :entries

  def self.from_omniauth(auth)
    logger.debug "omniauth #{auth.inspect}"
    User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end
