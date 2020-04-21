function NavbarBuilder() {

  function renderDropdownMenu(item){
    var i, ref;
    ref = $(item).find('ul li a');
    for(i = 0; i < ref.length; i++) {
      $(ref[i]).addClass('dropdown-item').removeClass('nav-link');
    }
    ref = $(item).find('ul');
    for(i = 0; i < ref.length; i++) {
      renderDropdownLinks(ref[i]);
    }
  }

  function renderDropdownLinks(item) {
    var links = $(item).find('li a');
    klass = 'dropdown-menu';
    if($(item).parent().hasClass('dropdown-menu-right')) {
      klass += ' dropdown-menu-right';
    }
    var div = $('<div></div>').addClass(klass).attr('aria-labelledby', 'navbarDropdown').append(links);
    $(item).replaceWith(div);
  }

  function prependClass(item, klass) {
    if($(item).attr('class')  ) {
      klass += ' ' + $(item).attr('class');
    }
    $(item).addClass(klass);
    if($(item).hasClass('justify-content-end')) {
      $(item).removeClass('mr-auto');
    }
  }

  function renderIconLink(item) {
    if($(item).attr('icon')  ) {
      $(item).html("<i class=\"fa fa-" + $(item).attr('icon') + "\"></i>&nbsp;" + $(item).text());
    }
  }

  return {
    create: function () {
      // backup
      $('#navigation').data('navbar', $('#navigation').html());

      var i, ref;
      ref = $('#navigation ul');
      for(i = 0; i < ref.length; i++) {
        prependClass(ref[i], 'navbar-nav mr-auto');
      }
      $('#navigation ul li').addClass('nav-item');
      $('#navigation ul li a').addClass('nav-link');
      $('#navigation ul li ul').parent().addClass('dropdown');
      $('#navigation ul li.dropdown').children('a').addClass('dropdown-toggle').attr(
        {id: 'navbarDropdown', role: 'button', 'aria-haspopup': 'true', 'aria-expanded': 'false', 'data-toggle': 'dropdown'}
      );
      ref = $('#navigation ul li.dropdown');
      for(i = 0; i < ref.length; i++) {
        renderDropdownMenu(ref[i]);
      }
      ref = $('#navigation ul li a');
      for(i = 0; i < ref.length; i++) {
        renderIconLink(ref[i]);
      }
    },
    destroy: function () {
      // restore
      $('#navigation').html($('#navigation').data('navbar'));
    }
  };
}

document.addEventListener('turbolinks:load', function(){
  var navbar = new NavbarBuilder();
  navbar.create();
}, {once: true});

document.addEventListener('turbolinks:render', function(){
  var navbar = new NavbarBuilder();
  navbar.create();
});

document.addEventListener('turbolinks:before-render', function(){
  var navbar = new NavbarBuilder();
  navbar.destroy();
});
