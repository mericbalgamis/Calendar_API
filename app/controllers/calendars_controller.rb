require "rubygems"
require "json"

class CalendarsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
    render json: @calendars
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
    @event = Calendar.find(params[:id])
    render json: @event
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit

  end

  # POST /calendars
  # POST /calendars.json
  def create
    @calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else

        @data = JSON.parse(format)
        @data.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }


        #format.html { render :new }
        #format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search_with_keyword
    @calendars = Calendar.all

    results = Array.new
    # 2018-07-14T07:29:39.844803+00:00 heroku[router]: at=info method=GET path="/calendars/search/deneme" host=immense-coast-39524.herokuapp.com request_id=43b41567-cde1-4fac-90ef-3287498050bf fwd="193.140.110.35" dyno=web.1 connect=0ms service=12ms status=500 bytes=1841 protocol=https
    # 2018-07-14T07:29:39.835824+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] Started GET "/calendars/search/deneme" for 193.140.110.35 at 2018-07-14 07:29:39 +0000
    # 2018-07-14T07:29:39.837358+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] Processing by CalendarsController#search_with_keyword as HTML
    # 2018-07-14T07:29:39.837442+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf]   Parameters: {"keyword"=>"deneme"}
    # 2018-07-14T07:29:39.841959+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf]   [1m[36mCalendar Load (1.6ms)[0m  [1m[34mSELECT "calendars".* FROM "calendars"[0m
    # 2018-07-14T07:29:39.845346+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] Completed 500 Internal Server Error in 8ms (ActiveRecord: 1.6ms)
    # 2018-07-14T07:29:39.845940+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf]
    # 2018-07-14T07:29:39.846019+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] NoMethodError (undefined method `downcase' for nil:NilClass):
    # 2018-07-14T07:29:39.846062+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf]
    # 2018-07-14T07:29:39.846117+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] app/controllers/calendars_controller.rb:84:in `block in search_with_keyword'
    # 2018-07-14T07:29:39.846118+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] app/controllers/calendars_controller.rb:82:in `each_entry'
    # 2018-07-14T07:29:39.846119+00:00 app[web.1]: [43b41567-cde1-4fac-90ef-3287498050bf] app/controllers/calendars_controller.rb:82:in `search_with_keyword'
    @calendars.each_entry { |result|

      if(!(result.content.nil? || result.title.nil?))
        if params['keyword'] == result.content.downcase
            results << result
        else if params['keyword'] == result.title.downcase
               results << result
             end
        end
      end
    }

    render json: results
  end

  before_action :set_cors

  def set_cors
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:title, :content, :location, :start_date, :start_time, :end_date, :end_time, :repeat, :reminder)
    end
end
