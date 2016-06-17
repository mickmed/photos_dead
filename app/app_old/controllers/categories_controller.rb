class CategoriesController < ApplicationController

 
 
def index
  @cats = Category.all
  @categories = Category.all.paginate(page: params[:page])
end

def show
  @category = Category.find(params[:id])
  #@items = @user.items.paginate(page: params[:page])
  #debugger
end
    
 
 
 
 def new
  @category = Category.new
  @cats = Category.all
 end
  
 def create
   @cats = Category.all
  @category = Category.new(category_params)
  if params[:title].nil?
    if @category.save
      flash[:success] = "category created!"
      render 'edit'
    else
      redirect_to root_path
    end
  end
end
  
  
def edit
  @category = Category.find(params[:id])
end

def update
  @category = Category.find(params[:id])
  if @category.update_attributes(category_params)
    # Handle a successful update.
    flash[:success] = "cat updated"
    redirect_to categories_path
  else
    render 'edit'
  end
end
  
def destroy
  Category.find(params[:id]).destroy
  flash[:success] = "photo deleted"
  redirect_to request.referrer || root_url
end


private

def category_params
      params.require(:category).permit(:name)
    end

end
