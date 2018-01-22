class NavbarBuilder

  render: ->
    @prepend_class(i, 'navbar-nav mr-auto') for i in $('#navigation ul')
    $('#navigation ul li').addClass('nav-item')
    $('#navigation ul li a').addClass('nav-link')
    $('#navigation ul li ul').parent().addClass('dropdown')
    $('#navigation ul li.dropdown').children('a').addClass('dropdown-toggle').attr(
      {id: 'navbarDropdown', role: 'button', 'aria-haspopup': 'true', 'aria-expanded': 'false', 'data-toggle': 'dropdown'}
    )
    @render_dropdown_menu i for i in $('#navigation ul li.dropdown')
    @render_icon_a i for i in $('#navigation ul li a')

  render_dropdown_menu: (item) ->
    links = jQuery(item).find('ul li a')
    jQuery(l).addClass('dropdown-item').removeClass('nav-link') for l in links
    @render_dropdown_links (i) for i in jQuery(item).find('ul')

  render_dropdown_links: (item) ->
    el = jQuery(item)
    links = el.find('li a')

    klass = 'dropdown-menu'
    klass += ' dropdown-menu-right' if el.hasClass('dropdown-menu-right')
    div = $('<div></div>').addClass('dropdown-menu').attr('aria-labelledby': 'navbarDropdown').append(links)
    el.replaceWith(div)

  prepend_class: (item, klass) ->
    el = jQuery(item)
    if el.attr('class')
      klass += " #{el.attr('class')}"
      el.removeClass(jQuery(item).attr('class'))

    el.addClass(klass)

    if el.hasClass('justify-content-end')
      el.removeClass('mr-auto')

  render_icon_a: (item) ->
    el = jQuery(item)
    if el.attr('icon')
      el.html("<i class=\"fa fa-fw fa-#{el.attr('icon')}\"></i>&nbsp;#{el.text()}")

$(document).on 'turbolinks:load', ->
  navbar = new NavbarBuilder
  navbar.render()
