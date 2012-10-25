class PacientesController < InheritedResources::Base
  respond_to :json
  def edit
    @paciente = Paciente.find(params[:id])
    @clinicalhistory = Clinicalhistory.find_by_id(params[:clinicalhistory])
    if params[:clinicalhistory].nil?
      @clinicalhistory = @paciente.clinicalhistories.order("assessmentdate DESC").first
    end 
  end

  def update
    @paciente = Paciente.find(params[:id])
    @clinicalhistory = Clinicalhistory.find(params[:clinicalhistory][:id])
    respond_to do |format|
      if @paciente.update_attributes(params[:paciente]) && @clinicalhistory.update_attributes(params[:clinicalhistory])
        flash[:notice] = I18n.t(:paciente_successfully_updated, :updated => @paciente)
        format.html {redirect_to(edit_paciente_path(@paciente))}
      else
        flash[:error] = I18n.t(:error_updated)
        format.html {redirect_to(edit_paciente_path(@paciente))}
      end
    end
  end

  def create
    @paciente = Paciente.new(params[:paciente])
    respond_to do |format| 
      if @paciente.save
        flash[:notice] = I18n.t(:paciente_successfully_created, :created => @paciente)
        format.html { redirect_to(edit_paciente_path(@paciente))}
      else
        format.js { render :new }
        format.html { render :new }
      end
    end
  end
  
  
  def new_clinicalhistory
    clinicalhistory = Clinicalhistory.new
    clinicalhistory.medicalhistory = "Insertar Datos"
    @paciente = Paciente.find(params[:id])
    @paciente.clinicalhistories << clinicalhistory
    respond_to do |format|
      flash[:notice] = (:new_clinicalhistory_saved)
      format.html { redirect_to(edit_paciente_path(@paciente)) }
      format.xml  { head :ok }
    end
  end

  def collection
    @pacientes ||= end_of_association_chain.page(params[:page]).per(20)
  end
 
end
