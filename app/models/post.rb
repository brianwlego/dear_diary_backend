class Post < ApplicationRecord
    belongs_to :user
    has_many :post_likes, :dependent => :delete_all
    has_many :users, through: :post_likes
    has_many :comments, :dependent => :delete_all
    has_many :users, through: :comments


    def determine_time
        a = (Time.now-self.updated_at.to_i).to_i
        
        case a
            when 0..10 then 'just now'
            when 11..59 then a.to_s+' seconds ago' 
            when 60..119 then '1 minute ago' #120 = 2 minutes
            when 120..3540 then (a/60).to_i.to_s+' minutes ago'
            when 3541..7100 then '1 hour ago' # 3600 = 1 hour
            when 7101..82800 then ((a+99)/3600).to_i.to_s+' hours ago' 
            when 82801..172000 then 'a day ago' # 86400 = 1 day
            when 172001..518400 then ((a+800)/(60*60*24)).to_i.to_s+' days ago'
            else self.updated_at.strftime("%B %d")
        end
    end

end
