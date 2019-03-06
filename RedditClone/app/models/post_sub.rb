class PostSub < ApplicationRecord 
    validates :sub_id, uniqueness: {scope: :post_id}

    belongs_to :sub 
    belongs_to :post

    # belongs_to :user, 
    #     through: :post,
    #     source: :author 

end 