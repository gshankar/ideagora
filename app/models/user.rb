class User < ActiveRecord::Base
  has_many :attendances
  has_many :camps, :through => :attendances
  has_many :projects, :dependent => :destroy
  has_many :notices
  
  validates_presence_of :first_name, :email
  validates_uniqueness_of :email
  
  scope :organisers, :joins => :attendances, :conditions => ["attendances.organiser = ? and attendances.camp_id = ?", true, 1] 
  
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  
  def full_name
    if last_name
      first_name + ' ' + last_name
    else
      first_name
    end
  end
  
  def organiser?
    User.organisers.include?(self)
  end
  
  def self.authenticate(param)
    user = find_by_email(param) || find_by_twitter(param)
    user ? user : nil
  end
end
