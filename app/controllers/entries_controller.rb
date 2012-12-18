class EntriesController < ApplicationController
  before_filter :force_auth

  def force_auth
    redirect_to '/auth/open_id' unless current_user
  end

  # GET /entries
  # GET /entries.json
  def index
    @entry = Entry.new
    if params && params[:month] && params[:year]
      @limit_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      tmp = Entry.where('created_at >= ?', @limit_date.beginning_of_month()).where('created_at <= ?', @limit_date.end_of_month()).group_by { |entry| entry.created_at.strftime("%F") }
    else
      @limit_date = Date.today.beginning_of_month()
      tmp = Entry.where('created_at >= ?', 1.month.ago).all.group_by { |entry| entry.created_at.strftime("%F") }
    end
    @entries = tmp.inject({}) { |h, (day, entries)| h[day] = entries.group_by(&:user); h }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @multiline = true
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user.name

    respond_to do |format|
      if @entry.save
        format.html { redirect_to entries_url, :notice => 'Entry was successfully created.' }
        format.json { render :json => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.json { render :json => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to entries_url, :notice => 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end
end
