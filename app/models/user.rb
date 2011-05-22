class User < ActiveRecord::Base
  belongs_to :camp
  
  has_many :projects
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.authenticate(param)
    user = find_by_email(param) || find_by_twitter(param)
    user ? user : nil
  end
end
