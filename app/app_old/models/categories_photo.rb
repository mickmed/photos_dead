class CategoriesPhoto < ActiveRecord::Base
  self.primary_key = "row_id"
  
  belongs_to :photo
  belongs_to :category
 
 
   
   
   

    

end