class DataTableBuilder
  constructor: ->
    @defaultOptions = {
      destroy: true
      autoWidth: false
      responsive: true
      stateSave: true
    }

  go: ->
    # users
    div = $('table#users')
    @initTable(container: div)
    # ldap create
    div = $('table#ldap_create')
    @initTable(container: div, params: {
      paging: false
      # default sorting: username (2nd column) asc
      order: [[1,'asc']]
      columnDefs: [
        { orderable: false, className: 'select-checkbox', targets: 0 }
      ]
      select: { style: 'multi', info: false }
    })

    # logs
    div = $('table#logs')
    @initTable(container: div, params: {
      processing: true
      serverSide: true
      ajax: div.data('source')
      # default sorting: date (2nd column) desc
      order: [[1,'desc']]
      columns: [
        { data: 'severity', searchable: false }
        { data: 'date',     searchable: false }
        { data: 'message' }
        { data: 'category', searchable: false }
      ]
      columnDefs: [
        { orderSequence: ['desc', 'asc'], targets: [ 1 ] },
        { className: 'text-center', "targets": [ 0 ] }
      ]
    })

    # datatable class
    div = $('table.datatable')
    @initTable(container: div)

    # datatable class (server side processing)
    div = $('table[remote=true].datatable')
    @initTable(container: div, params: {
      processing: true
      serverSide: true
      ajax: div.data('source')
    })

  initTable: ({container, params} = {}) ->
    if container.length > 0
      params ?= {}
      # add custom params if any
      settings = $.extend({}, @defaultOptions, params)
      # add language
      settings = $.extend({}, settings, {language: Chaltron.locales('datatable')})

      table = container.DataTable(settings)
      document.addEventListener 'turbolinks:before-cache', ->
        table.destroy()

$(document).on 'turbolinks:load', ->
  table = new DataTableBuilder
  table.go()

# specify date format (for sorting)
$.fn.dataTable.moment('DD MMM HH:mm')

$ ->
  $('form#ldap_create').on 'submit', (e) ->

    count = $('table#ldap_create').DataTable().rows( { selected: true } ).count()

    if count == 0
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

    for i in [0..count-1]
      $('<input/>', {
        name: 'uids[]',
        type: 'hidden',
        multiple: 'multiple',
        value: $('table#ldap_create').DataTable().rows( { selected: true } ).data()[i][1]
      }).appendTo(@)
