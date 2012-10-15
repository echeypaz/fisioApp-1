class EventsController < InheritedResources::Base
  def index   
    # full_calendar will hit the index method with query parameters
    # 'start' and 'end' in order to filter the results for the
    # appropriate month/week/day.  It should be possiblt to change
    # this to be starts_at and ends_at to match rails conventions.
    # I'll eventually do that to make the demo a little cleaner.
    @events = Event.scoped  
    @events = @events.after(params['start']) if (params['start'])
    @events = @events.before(params['end']) if (params['end'])
    
    if (!params[:paciente_id].blank?)
      @events = @events.where(:paciente_id => params['paciente_id']) 
    end
    if (!params[:center].blank?)
      @events = @events.where(:center_id => params['center_id']) 
    end
    if (!params[:specialist_id].blank?)
      @events = @events.where(:specialist_id => params['specialist_id']) 
    end
        
    @event = Event.new
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @events }
      format.js  { render :json => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
      format.js { render :json => @event.to_json }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    respond_to do |format|
      if @event.save
        flash[:notice] = "Cita para el paciente creada correctamente"
        format.html { redirect_to events_path}
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /events/1
  # PUT /events/1.xml
  # PUT /events/1.js
  # when we drag an event on the calendar (from day to day on the month view, or stretching
  # it on the week or day view), this method will be called to update the values.
  # viv la REST!
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
        format.js { head :ok}
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
        format.js  { render :js => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
  end
  
  def info
    paciente = Paciente.find(params[:id])
    respond_to do |format|
      format.json do
        render :json => paciente
      end
    end
  end
  
  def search_paciente_events
    events = Event.where(:paciente_id=>params[:id]) unless params[:id].blank?
    respond_to do |format|
      format.json { render :json => events.map {|event| [event.title, 10, event.starts_at, event.paciente_id] }.to_json }
    end
  end
  
  
  def confirm
    @event = Event.find(params[:id])  
    @event.attended = true
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path}
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end
end
