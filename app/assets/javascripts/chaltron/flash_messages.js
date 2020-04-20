document.addEventListener('turbolinks:load', function(){
  
  // flash messages
  var flash = $('.flash-container div.alert');
  if (flash.length > 0) {
    flash.click(function(){
      $(this).fadeOut();
    });
    setTimeout(function(){
      flash.fadeOut();
    }, 5000);
  }

});
