class User < ApplicationRecord
	validates :email ,uniqueness:true
	has_secure_password
	validates:password ,presence:true
end
