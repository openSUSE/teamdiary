class Entry < ActiveRecord::Base
  attr_accessible :color, :content, :user
  before_validation :default_color, :on => :create

  validates :user, :presence => true
  validates :content, :presence => true

  private
    def default_color
      self.color ||= 'green'
    end
end
