class LinePasController < ApplicationController
  # GET /line_pas
  # GET /line_pas.xml
  def index
    @line_pas = LinePa.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_pas }
    end
  end

  # GET /line_pas/1
  # GET /line_pas/1.xml
  def show
    @line_pa = LinePa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_pa }
    end
  end

  # GET /line_pas/new
  # GET /line_pas/new.xml
  def new
    @line_pa = LinePa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_pa }
    end
  end

  # GET /line_pas/1/edit
  def edit
    @line_pa = LinePa.find(params[:id])
  end

  # POST /line_pas
  # POST /line_pas.xml
  def create
    @line_pa = LinePa.new(params[:line_pa])

    respond_to do |format|
      if @line_pa.save
        flash[:notice] = 'LinePa was successfully created.'
        format.html { redirect_to(@line_pa) }
        format.xml  { render :xml => @line_pa, :status => :created, :location => @line_pa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_pa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_pas/1
  # PUT /line_pas/1.xml
  def update
    @line_pa = LinePa.find(params[:id])

    respond_to do |format|
      if @line_pa.update_attributes(params[:line_pa])
        flash[:notice] = 'LinePa was successfully updated.'
        format.html { redirect_to(@line_pa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_pa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_pas/1
  # DELETE /line_pas/1.xml
  def destroy
    @line_pa = LinePa.find(params[:id])
    @line_pa.destroy

    respond_to do |format|
      format.html { redirect_to(line_pas_url) }
      format.xml  { head :ok }
    end
  end
end
