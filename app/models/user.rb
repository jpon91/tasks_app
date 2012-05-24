class User < ActiveRecord::Base
  attr_accessible :email, :username,:password,:password_confirmation
  validates_uniqueness_of :email, :username
  validates_presence_of :email, :username
  has_secure_password
  has_many :tasks
end
