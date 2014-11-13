$ ->
  # Flash
  if (flash = $(".flash-container div.alert")).length > 0
    flash.click -> $(@).fadeOut()
    setTimeout (-> flash.fadeOut()), 10000

$(document).on 'page:change', ->
  $('.datatable').DataTable({
    # ajax: ...,
    autoWidth: false,
    pagingType: 'full_numbers',
    # processing: true,
    # serverSide: true,
    responsive: true

    # Optional, if you want full pagination controls.
    # Check dataTables documentation to learn more about available options.
    # http://datatables.net/reference/option/pagingType
  });
