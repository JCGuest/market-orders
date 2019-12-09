class User < ActiveRecord::Base
has_many :orders
has_secure_password
validates :username, uniqueness: true
#validates_uniqueness_of :username
end