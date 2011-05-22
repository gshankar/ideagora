class User < ActiveRecord::Base
  belongs_to :camp
  
  has_many :projects, :dependent => :destroy
  
  validates_presence_of :first_name, :email
  validates_uniqueness_of :email
  
  def full_name
    if last_name
      first_name + ' ' + last_name
    else
      first_name
    end
  end
  
  def self.authenticate(param)
    user = find_by_email(param) || find_by_twitter(param)
    user ? user : nil
  end
end
