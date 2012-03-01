class AnnouncersController < ApplicationController
  # GET /announcers
  # GET /announcers.xml
  def index
    @announcers = Announcer.all
    @json = @announcers.to_gmaps4rails

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @announcers }
      format.json  { render :json => @announcers }
    end
  end

  # GET /announcers/1
  # GET /announcers/1.xml
  def show
    @announcer = Announcer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @announcer }
    end
  end

  # GET /announcers/new
  # GET /announcers/new.xml
  def new
    @announcer = Announcer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @announcer }
    end
  end

  # GET /announcers/1/edit
  def edit
    @announcer = Announcer.find(params[:id])
  end

  # POST /announcers
  # POST /announcers.xml
  def create
    @announcer = Announcer.new(params[:announcer])

    respond_to do |format|
      if @announcer.save
        format.html { redirect_to(@announcer, :notice => 'Announcer was successfully created.') }
        format.xml  { render :xml => @announcer, :status => :created, :location => @announcer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @announcer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /announcers/1
  # PUT /announcers/1.xml
  def update
    @announcer = Announcer.find(params[:id])

    respond_to do |format|
      if @announcer.update_attributes(params[:announcer])
        format.html { redirect_to(@announcer, :notice => 'Announcer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @announcer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /announcers/1
  # DELETE /announcers/1.xml
  def destroy
    @announcer = Announcer.find(params[:id])
    @announcer.destroy

    respond_to do |format|
      format.html { redirect_to(announcers_url) }
      format.xml  { head :ok }
    end
  end
end
