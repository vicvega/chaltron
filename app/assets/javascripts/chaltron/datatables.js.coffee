class DataTableBuilder
  constructor: ->
    @defaultOptions = {
      destroy: true,
      autoWidth: false,
      responsive: true
    }

  go: ->
    # users
    div = $('table#users')
    @initTable(container: div)
    # ldap create
    div = $('table#ldap_create')
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
    div = $('table.datatable')
    @initTable(container: div)

  initTable: ({container, params} = {}) ->
    if container.length > 0
      params ?= {}
      # add custom params if any
      settings = $.extend({}, @defaultOptions, params)
      # add language
      settings = $.extend({}, settings, {language: Chaltron.locales('datatable')})

      container.DataTable(settings)

$(document).on 'page:change', ->
  table = new DataTableBuilder
  table.go()

$ ->
  $('form#ldap_create').on 'submit', (e) ->
    table = TableTools.fnGetMasters()[0]
    data = table.fnGetSelectedData()

    if data.length == 0
      message = Chaltron.locales('error_message')
      label = Chaltron.locales('error_label')

      flash = $("div.alert-warning:contains('#{message}')")
      if flash.length == 0
        # display warning flash message
        flash = $("<div><strong>#{label}</strong>: #{message}</div>").addClass('alert alert-warning')
        $('.flash-container').append(flash)
      else
        flash.show()
      # closable
      flash.click -> $(@).fadeOut()
      # self disappearing
      setTimeout (-> flash.fadeOut()), 5000

      e.preventDefault()

    for d in data
      $('<input/>', {
        name: 'uids[]',
        type: 'hidden',
        multiple: 'multiple',
        value: d[1]
      }).appendTo(@)
