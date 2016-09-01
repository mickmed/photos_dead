class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]
  before_action :random_photos, :except => [:create, :update, :destroy, :show]
  before_action :random_messages 
  before_action :categories
  # GET /messages
  # GET /messages.json
  def index
  
  end


  def show
    @messages = Message.all
  end

  def new
    @messages = Message.all
    
    @message = Message.new
   
  end

  # GET /messages/1/edit

  def edit
    @messages = Message.all
   
  end

 
  def create
    @messages = Message.all
    

    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)

    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)

    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:message)
  end

  def random

    if Rails.env.production?
      @messages = Message.all.order("RAND()").limit(6)
    else
      @messages = Message.all.order("RANDOM()").limit(6)
    end
  end
 def photo_params
    params.require(:photo).permit(:title, :description, :picture, :date_taken, category_ids:[])
  end
  
  def random_messages
    if Rails.env.production?
      @messages = Message.all.order("RAND()").limit(6)
    else
      @messages = Message.all.order("RANDOM()").limit(6)
    end
  end
  
  def random_photos
    if Rails.env.production?
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RAND()").limit(6)
    else
      @photos = Photo.all.where.not(categories: {id: 1}).includes(:categories).order("RANDOM()").limit(6)
    end
  end
  
  def categories
    @cats = Category.where.not(id: 1)
  end
  
  def authenticate
    @shoonga = authenticate_or_request_with_http_basic do |username, password|
        username == "we8vds" && password == "4vght"
    end
  end
end
