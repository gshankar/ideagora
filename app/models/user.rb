class User < ActiveRecord::Base
  belongs_to :camp
  
  def self.authenticate(param)
    user = find_by_email(param) || find_by_twitter(param)
    user ? user : nil
  end
end
