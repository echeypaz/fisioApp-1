  def searchable_association(form, association, params = {})
    def_opt = {
        :input_html => {"data-placeholder" => t(:select)},
        :multiple => false,
        :include_blank => false,
        :ajax => false }
    options = def_opt.deep_merge params
    multiple = options.delete(:multiple)
    classes = options[:input_html].delete(:class).to_s.split(" ")
    ajax = options.delete(:ajax)
    # Si es por ajax, no puede ser múltiple (de momento) y contiene sólo el
    # elemento actual o un elemento vacío (hasta que traigamos más por ajax)
    if ajax
      ref = form.object.send(association)
      if ref.nil?
        options[:collection] = [ ["", ""] ]
      else
        options[:collection] = [ref]
      end
      multiple = false
    end
    classes << "chzn-select"
    classes << "multiselect" if multiple
    options[:input_html][:multiple] = multiple
    options[:input_html][:class] = classes.join(" ")
    form.association association, options
  end
