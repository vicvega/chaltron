document.addEventListener('turbolinks:load', function(){
  var defaultOptions = {
    destroy: true,
    autoWidth: false,
    responsive: true,
    stateSave: true,
    language: Chaltron.translate('datatables')
  };

  // generic datatable
  var container = $('table.datatable');
  if (container.length > 0) {
    var table = container.DataTable(defaultOptions);
    document.addEventListener('turbolinks:before-cache', function() {
      table.destroy();
    });
  }
});
