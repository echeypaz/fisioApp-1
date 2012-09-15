module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "Usabi")
  end
  def logousabi
    image_tag("logousabismall.png", :alt => "Usabi, tu socio tecnologico")
  end
  def informes
    image_tag("menu/informes.png", :alt => "Seccion de informes")
  end
  def facturacion
    image_tag("menu/facturacion.png", :alt => "Facturacion")
  end
  def paciente
    image_tag("menu/paciente.png", :alt => "Listado de pacientes") + t(:paciente)
  end
  def pacientes
    image_tag("menu/pacientes.png", :alt => "Ficha del paciente")
  end
  def citas
    image_tag("menu/citas.png", :alt => "Gestion de citas")
  end
  def remove
    image_tag("icono/delete.png", :alt => "Borrar")
  end
end
