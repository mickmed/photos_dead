class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:index, :show]
  def authenticate
    @shoonga = authenticate_or_request_with_http_basic do |username, password|
  username == "we8vds" && password == "4vght"
 end
  end

  # GET /messages
  # GET /messages.json
  def index
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)
    @messages = Message.all

    if Rails.env.production?
      @messages = Message.all.order("RAND()").limit(6)
    else
      @messages = Message.all.order("RANDOM()").limit(6)
    end
    

  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)
  end

  # GET /messages/new
  def new
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)

    @message = Message.new
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)
  end

  # GET /messages/1/edit

  def edit
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)
  end

  # POST /messages
  # POST /messages.json
  def create
    @messages = Message.all
    @photos = Photo.all.paginate(:page => params[:page], :per_page => 5)
    @cats = Category.where.not(id: 1)

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
end
