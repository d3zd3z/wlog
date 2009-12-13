class LineEatsController < ApplicationController
  # GET /line_eats
  # GET /line_eats.xml
  def index
    @line_eats = LineEat.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_eats }
    end
  end

  # GET /line_eats/1
  # GET /line_eats/1.xml
  def show
    @line_eat = LineEat.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_eat }
    end
  end

  # GET /line_eats/new
  # GET /line_eats/new.xml
  def new
    @line_eat = LineEat.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_eat }
    end
  end

  # GET /line_eats/1/edit
  def edit
    @line_eat = LineEat.find(params[:id])
  end

  # POST /line_eats
  # POST /line_eats.xml
  def create
    @line_eat = LineEat.new(params[:line_eat])

    respond_to do |format|
      if @line_eat.save
        flash[:notice] = 'LineEat was successfully created.'
        format.html { redirect_to(@line_eat) }
        format.xml  { render :xml => @line_eat, :status => :created, :location => @line_eat }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_eat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_eats/1
  # PUT /line_eats/1.xml
  def update
    @line_eat = LineEat.find(params[:id])

    respond_to do |format|
      if @line_eat.update_attributes(params[:line_eat])
        flash[:notice] = 'LineEat was successfully updated.'
        format.html { redirect_to(@line_eat) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_eat.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_eats/1
  # DELETE /line_eats/1.xml
  def destroy
    @line_eat = LineEat.find(params[:id])
    @line_eat.destroy

    respond_to do |format|
      format.html { redirect_to(line_eats_url) }
      format.xml  { head :ok }
    end
  end
end
