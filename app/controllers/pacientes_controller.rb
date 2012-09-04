class PacientesController < InheritedResources::Base
  def edit
    @paciente = Paciente.find(params[:id])
    @centers = Center.all
    @specialisttypes = Specialisttype.find(:all)
    @provenances = Provenance.find(:all)
    if params[:clinicalhistory].nil?
      @clinicalhistory = @paciente.clinicalhistories.order("assessmentdate DESC").first
   else
      @clinicalhistory = Clinicalhistory.find_by_id(params[:clinicalhistory])
    end

  end

  def create
    @paciente = Paciente.new(params[:paciente])
     respond_to do |format|
      if @paciente.save
        flash[:notice] = "Ficha de paciente creada correctamente"
        format.html { redirect_to(edit_paciente_path(@paciente)) }
        format.xml  { render :xml => @paciente, :status => :created, :location => @invoicehead }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @paciente = Paciente.find(params[:id])
    @clinicalhistory = Clinicalhistory.find_by_id(params[:clinicalhistory][:id])
    respond_to do |format|
      if @paciente.update_attributes(params[:paciente])
        if @clinicalhistory.update_attributes(params[:clinicalhistory])
          flash[:notice] = "Ficha de paciente actualizada correctamente"
          format.html { redirect_to(edit_paciente_path(@paciente)) }
          format.xml  { head :ok }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy
    respond_to do |format|
      format.html { redirect_to(pacientes_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_clinicalhistory
    update! do |success, failure|
      success.js do
        flash[:notice] = t(:clinicalhistory_updated)
      end
      failure.js do
        render :new_clinicalhistory
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
