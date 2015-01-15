class @Chaltron
  @locales: (field) ->
    lang = Chaltron::lang ? 'en'
    ret = switch lang
      when 'it' then {
        error_message: 'Selezionare almeno una riga',
        error_label: 'Attenzione',
        datatable: {
          sEmptyTable:     'Nessun dato presente nella tabella',
          sInfo:           'Vista da _START_ a _END_ di _TOTAL_ elementi',
          sInfoEmpty:      'Vista da 0 a 0 di 0 elementi',
          sInfoFiltered:   '(filtrati da _MAX_ elementi totali)',
          sInfoPostFix:    '',
          sInfoThousands:  ',',
          sLengthMenu:     'Visualizza _MENU_ elementi',
          sLoadingRecords: 'Caricamento...',
          sProcessing:     'PIPPO...',
          sSearch:         'Cerca:',
          sZeroRecords:    'La ricerca non ha portato alcun risultato.',
          oPaginate: {
              sFirst:      'Inizio',
              sPrevious:   'Precedente',
              sNext:       'Successivo',
              sLast:       'Fine'
          },
          oAria: {
              sSortAscending:  ': attiva per ordinare la colonna in ordine crescente',
              sSortDescending: ': attiva per ordinare la colonna in ordine decrescente'
          }
        }
      }
      else {
        error_message: 'Select at least a row',
        error_label: 'Warning',
        datatable: {
          sEmptyTable:     'No data available in table',
          sInfo:           'Showing _START_ to _END_ of _TOTAL_ entries',
          sInfoEmpty:      'Showing 0 to 0 of 0 entries',
          sInfoFiltered:   '(filtered from _MAX_ total entries)',
          sInfoPostFix:    '',
          sInfoThousands:  ',',
          sLengthMenu:     'Show _MENU_ entries',
          sLoadingRecords: 'Loading...',
          sProcessing:     'Processing...',
          sSearch:         'Search:',
          sZeroRecords:    'No matching records found',
          oPaginate: {
              sFirst:    'First',
              sLast:     'Last',
              sNext:     'Next',
              sPrevious: 'Previous'
          },
          oAria: {
              sSortAscending:  ': activate to sort column ascending',
              sSortDescending: ': activate to sort column descending'
          }
        }
      }
    ret[field]
