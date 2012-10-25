// address es una url que puede tener "/blabla/<a_sustituir>/bla". En ese
// caso, se sustituye por el valor del campo "a_sustituir" en el formulario
//
// params es un hash con varios {nombre: valor} Se añaden todos como parámetros
// a la url. Si valor tiene la forma ">#campo" se busca el campo. Si se
// encuentra y tiene algún valor distinto de la ristra vacía, se añade a la
// url. Si no, se ignora. Si el valor no tiene la forma ">#campo",
// simplemente se añade el parámetro a la url.
function url_for(address, params) {
  var url = address;
  var data = {};
  var key = null;

  url = url.replace(/<([^>]*)>/g, function(str, name) {
      return encodeURI($("#"+name).val());
  });
  for (key in params) {
    if (params[key].substring(0,2) === ">#") {
      var item = $(params[key].substring(1));
      // Si lo encuentra...
      if (item.size()) {
        // Y tiene un valor...
        var val = item.val();
        // Se asigna
        if (val) { data[key] = val; }
      }
    } else {
      data[key] = params[key];
    }
  }
  return {url: url, data: data};
}
