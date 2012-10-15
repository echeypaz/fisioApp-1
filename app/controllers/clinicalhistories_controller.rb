class ClinicalhistoriesController < InheritedResources::Base
  respond_to :xml, :json
  
  def show
    @centers = Center.find(:all)
    @specialisttypes = Specialisttype.find(:all)
    @clinicalhistory = Clinicalhistory.find(params[:id])
    @paciente = Paciente.find(@clinicalhistory.paciente_id)
    @clinicalhistories = Clinicalhistory.where(:paciente_id => @paciente).order("assessmentdate DESC")
  end

  def new
    @clinicalhistory = Clinicalhistory.new(params[:clinicalhistory])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clinicalhistory }
    end
  end

  def collection
    @search ||= end_of_association_chain
    @clinicalhistories ||= @search.page(params[:page]).per(20)
  end

end
