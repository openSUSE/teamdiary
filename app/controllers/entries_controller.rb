class EntriesController < ApplicationController
  before_filter :authentication
  before_filter :authorization, :only => [:update, :destroy, :edit]

  def authentication
    redirect_to auth_path('bugzilla') unless current_user
    redirect_to unconfirmed_path unless current_user.confirmed?
  end

  def authorization
    @entry = Entry.find(params[:id])
    if current_user != @entry.user 
      redirect_to( entry_path(@entry), :notice => "Sorry, you can only modify your own entries.")
    end
  end

  # GET /entries
  # GET /entries.json
  def index
    @entry = Entry.new
    if params && params[:month] && params[:year]
      @limit_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      tmp = Entry.where('created_at >= ?', @limit_date.beginning_of_month()).where('created_at <= ?', @limit_date.end_of_month())
    else
      @limit_date = Date.today.beginning_of_month()
      tmp = Entry.where('created_at >= ?', 1.month.ago)
    end
    @entries = {}
    tmp.includes(:user).each do |e|
      day = e.day
      @entries[day] ||= {}
      @entries[day][e.user] ||= []
      @entries[day][e.user] << e 
    end

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
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])
    @entry.user = current_user

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
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end
end
