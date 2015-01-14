class @DataTableBuilder
  constructor: ->
    @defaultOptions = {
      destroy: true,
      autoWidth: false,
      responsive: true
    }
    @lang = DataTableBuilder::lang ? 'en'

  go: ->
    # users
    div = $("table#users")
    @initTable(container: div)
    # ldap create
    div = $("table#ldap_create")
    @initTable(container: div, params: {
      paging: false,
      # default sorting: username (2nd column) asc
      aaSorting: [[1,'asc']]
      aoColumnDefs: [
        { bSortable: false, aTargets: [ 0 ] }
      ],
      dom: 'T<"clear">lfrtip',
      tableTools: {
        sRowSelect: 'multi',
        aButtons: [ ]
      }})

    # datatable class
    div = $("table.datatable")
    @initTable(container: div)

  initTable: ({container, params} = {}) ->
    if container.length > 0
      params ?= {}
      # add custom params if any
      settings = $.extend({}, @defaultOptions, params)
      # add language
      settings = $.extend({}, settings, {language: @languageObject()})

      container.DataTable(settings)

  languageObject: ->
    switch @lang
      when 'it' then {
        sEmptyTable:     "Nessun dato presente nella tabella",
        sInfo:           "Vista da _START_ a _END_ di _TOTAL_ elementi",
        sInfoEmpty:      "Vista da 0 a 0 di 0 elementi",
        sInfoFiltered:   "(filtrati da _MAX_ elementi totali)",
        sInfoPostFix:    "",
        sInfoThousands:  ",",
        sLengthMenu:     "Visualizza _MENU_ elementi",
        sLoadingRecords: "Caricamento...",
        sProcessing:     "PIPPO...",
        sSearch:         "Cerca:",
        sZeroRecords:    "La ricerca non ha portato alcun risultato.",
        oPaginate: {
            sFirst:      "Inizio",
            sPrevious:   "Precedente",
            sNext:       "Successivo",
            sLast:       "Fine"
        },
        oAria: {
            sSortAscending:  ": attiva per ordinare la colonna in ordine crescente",
            sSortDescending: ": attiva per ordinare la colonna in ordine decrescente"
        }
      }
      else {
        sEmptyTable:     "No data available in table",
        sInfo:           "Showing _START_ to _END_ of _TOTAL_ entries",
        sInfoEmpty:      "Showing 0 to 0 of 0 entries",
        sInfoFiltered:   "(filtered from _MAX_ total entries)",
        sInfoPostFix:    "",
        sInfoThousands:  ",",
        sLengthMenu:     "Show _MENU_ entries",
        sLoadingRecords: "Loading...",
        sProcessing:     "Processing...",
        sSearch:         "Search:",
        sZeroRecords:    "No matching records found",
        oPaginate: {
            sFirst:    "First",
            sLast:     "Last",
            sNext:     "Next",
            sPrevious: "Previous"
        },
        oAria: {
            sSortAscending:  ": activate to sort column ascending",
            sSortDescending: ": activate to sort column descending"
        }
      }

$(document).on 'page:change', ->
  table = new DataTableBuilder
  table.go()
