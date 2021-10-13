class User < ApplicationRecord
	validates :email ,uniqueness:true
	has_secure_password
	validates:password ,presence:true

	has_many :posts
	has_many :followers ,class_name: 'Follow' , foreign_key: 'follower_id'
	has_many :followees ,class_name: 'Follow' , foreign_key: 'followee_id'
end
