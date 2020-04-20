$(document).on('turbolinks:load', function() {
  container = $('table#ldap_create');
  if (container.length > 0) {

    var toggleButton = function() {
      var any = $('input.entry' + ':checkbox')
                .filter(function() { return this.checked; })
                .length > 0;
      if (any) {
        $('#ldap_create_button').prop('disabled', false);
      } else {
        $('#ldap_create_button').prop('disabled', true);
      }
    };
    // checkboxes
    $('input.entry' + ':checkbox:disabled').prop('indeterminate', true);
    $('input.entry' + ':checkbox').off().on('click', function() {
      toggleButton();
    });
    $('#entry-check-all').off().on('click', function() {
      $('input.entry' + ':checkbox:enabled').prop('checked', this.checked);
      toggleButton();
    });

    $('form#ldap_create').on('submit', function(event) {
      var selectedEntry = $('input.entry' + ':checkbox:checked')
                          .map(function() { return $(this).attr('data-entry'); })
                          .get();
      if(selectedEntry.lenght == 0) {
        // should nevere be here!!
        event.preventDefault();
      } else {
        $.each(selectedEntry, function(index, entry){
          $('<input/>', {
            name: 'uids[]',
            type: 'hidden',
            multiple: 'multiple',
            value: entry
          }).appendTo('form#ldap_create');
        });
      }
    });
  }
});
