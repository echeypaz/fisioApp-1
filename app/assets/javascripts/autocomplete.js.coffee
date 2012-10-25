# params es un objeto que indica qué campos del formulario hay que enviar y con
# qué nombre de parámetro. Por ej:
# {warehouse_id: "#search_warehouse_id_eq", customer_id: "#hidden_customer_id"}
init_chosen_autocomplete = (chosen_tag, url, params = null) ->
  chosen_tag.ajaxChosen
    delay: 500
  , (options, response) ->
    data = {}
    if params?
      for key of params
        item = $(params[key])
        # Si lo encuentra...
        if item.size()
          pval = item.val()
          # ...y tiene un valor, se asigna
          data[key] = pval if pval
    data['term'] = options.term
    url2 = url_for url, {}
    $.getJSON url2.url,
      data
    , (resp) ->
      terms = {}
      $.each resp, (k, v) ->
        terms[v.id] = v.value

      response terms

window.init_searchable = (scope) ->

  scope.find('.chzn-select').chosen({allow_single_deselect: true})

  scope.find("select[data-autocomplete-url]").each (i, e) ->
    init_chosen_autocomplete $(e), $(e).data("autocomplete-url")

  #init_chosen_autocomplete scope.find("#search_product_id_eq"), '/products',
  #  "search[customer_id_eq]": "#search_customer_id_eq"
  #  "search[department_id_eq]": "#search_deparment_id_eq"
