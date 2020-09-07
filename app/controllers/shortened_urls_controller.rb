class ShortenedUrlsController < ApplicationController
  before_action :find_url, only: [:show, :shortened]
  skip_before_action :verify_authenticity_token

  def index
    @url = Url.new
  end

  def show
    if @url.present?
      if @url.expired?
        @message = "URL Expired"
      else
        record_activity
        redirect_to @url.sanitize_url unless @url.expired?
      end
    else
      @message = "URL doesnot exist"
    end
  end

  def create
    @url = Url.new(url_params)
    @url.sanitize_url
    respond_to do |format|
      if @url.new_url?
        if  @url.save
          host = request.host_with_port
          @short_url = host + '/' + @url.short_url
          format.html { redirect_to @url, notice: 'url was successfully created.' }
          format.js
           format.json { render :show, status: :created, location: @url }
        else
          format.html { render action: "index" }
          format.js
          format.json { render json: @url.errors, status: :unprocessable_entity }
        end
      else
        format.js
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  def stats
    #@urls = Url.includes(:trackings).paginate(page: params[:page], per_page: 30)
    @urls = Url.preload(:trackings).paginate(page: params[:page],per_page: 30)

    @host = request.host_with_port
  end

  def shortened
    @url = Url.find_by_short_url(params[:short_url])
    host = request.host_with_port
    @short_url = host + '/' + @url.short_url
    @original_url = @url.sanitize_url
  end

  def fetch_original_url
    fetch_url = Url.find_by_short_url(params[:short_url])
    redirect_to fetch_url.sanitize_url
  end

  private
  def find_url
    @url = Url.find_by_short_url(params[:short_url])
  end

  def url_params
    params.require(:url).permit(:original_url)
  end

  def record_activity
    result = Geocoder.search(request.remote_ip).first
    @url.trackings.create(
      ip: result.data.fetch('ip',''),
      country: result.data.fetch('country','')
    )
  end

end
