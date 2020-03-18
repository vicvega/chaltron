document.addEventListener('turbolinks:load', function(){
  var defaultOptions = {
    destroy: true,
    autoWidth: false,
    responsive: true,
    stateSave: true,
    language: I18n.t('datatable')
  };
  // generic datatable
  var container = $('table.datatable');
  if (container.length > 0) {
    var table = container.DataTable(defaultOptions);
    document.addEventListener('turbolinks:before-cache', function() {
      table.destroy();
    });
  }
  // logs
  container = $('table#logs');
  if (container.length > 0) {
    var log_table = container.DataTable($.extend({}, defaultOptions, {
      processing: true,
      serverSide: true,
      ajax: container.data('source'),
      // default sorting: date (2nd column) desc
      order: [[1,'desc']],
      columns: [
        { data: 'severity', searchable: false },
        { data: 'date',     searchable: false },
        { data: 'message' },
        { data: 'category', searchable: false },
      ],
      columnDefs: [
        { orderSequence: ['desc', 'asc'], targets: [ 1 ] },
        { className: 'text-center', 'targets': [ 0 ] }
      ]
    }));

    document.addEventListener('turbolinks:before-cache', function() {
      log_table.destroy();
    });
  }
});
