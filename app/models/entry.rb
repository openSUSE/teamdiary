class Entry < ActiveRecord::Base
  attr_accessible :color, :content, :user
  before_validation :default_color, :on => :create
  before_validation :past_entry, :on => :create
  belongs_to :user

  validates :user, :presence => true
  validates :content, :presence => true

  private
    def default_color
      self.color ||= 'green'
    end
    def past_entry
      if /^Yesterday:/i =~ self.content
        self.content = self.content.gsub(/^Yesterday:\ ?/i,'');
        self.created_at = Date.yesterday.end_of_day()
      end
    end
end
