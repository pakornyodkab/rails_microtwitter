class User < ApplicationRecord
	validates :name ,uniqueness:true ,presence:true
	validates :email ,uniqueness:true ,presence:true
	has_secure_password
	validates:password ,presence:true
	validates :name ,presence:true

	has_many :posts
	has_many :followers ,class_name: 'Follow' , foreign_key: 'follower_id'
	has_many :followees ,class_name: 'Follow' , foreign_key: 'followee_id'
end
