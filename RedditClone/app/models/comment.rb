class Comment < ApplicationRecord 

    validates :content, presence: true 

    belongs_to :author,
        class_name: :User,
        foreign_key: :author_id

    belongs_to :post 

    belongs_to :parent_comment,
        foreign_key: :parent_comment_id,
        class_name: :Comment,
        optional: true 

    has_many :child_comments,
        foreign_key: :parent_comment_id,
        class_name: :Comment

    def show_all_children(deep = 1)
        all_comments = "<b>#{self.author.username}</b> #{self.content}".html_safe
        return all_comments if self.child_comments.empty?
        self.child_comments.each do |child| 
            all_comments += "<br>".html_safe
            all_comments += ("&nbsp&nbsp&nbsp"*deep).html_safe
            all_comments += child.show_all_children(deep + 1)          
        end 
        return all_comments 
    end


end 