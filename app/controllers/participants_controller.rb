class ParticipantsController < ApplicationController
  before_filter :authenticate, only: :index 

  def new
  	@participant = Participant.new
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def create
    @participant = Participant.new(params[:participant])
    if @participant.save
      redirect_to @participant
    else
      render 'new'
    end
  end

  def index
    @participants = Participant.paginate(page: params[:page])
  end

  def winner
    @participant = Participant.order("RANDOM()").first
  end

  private

    def authenticate
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        md5_of_password = Digest::MD5.hexdigest(password)  
        username == 'info@lengoo.de' && md5_of_password == 'e8b8ba0f288df62c6d7d8aed83251fc4'
    end
  end
end
