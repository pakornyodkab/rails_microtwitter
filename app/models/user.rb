class User < ApplicationRecord
	validates :name ,uniqueness:true ,presence:true
	validates :email ,uniqueness:true ,presence:true
	has_secure_password
	validates:password ,presence:true ,length: { in: 5..20 }
	validates :name ,presence:true

	has_many :posts
	has_many :followers ,class_name: 'Follow' , foreign_key: 'follower_id'
	has_many :followees ,class_name: 'Follow' , foreign_key: 'followee_id'


	def get_feed_post(uid) 
		#not complete
		user = User.find(uid)
		post_all = []
     	user.followers.each do |followers|
       		followee = User.find(followers.followee_id)
      		followee.posts.each do |post|
        		post_all.push(post) #followee post
        	end
        end
        return post_all.sort_by{|e| e.created_at}.reverse
	end

end
