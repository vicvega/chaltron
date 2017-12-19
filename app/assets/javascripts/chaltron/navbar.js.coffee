class NavbarBuilder

  constructor: ->
    # users
    div = $('#navigation')
    @data = JSON.parse(div.text())

  go: ->
    content = (@render_item_li(item) for item in @data).join('')
    $('#navigation').html(
      "<ul class=\"navbar-nav mr-auto\">#{content}</ul>"
    )

  render_dropdown: (item) ->
    klass = 'nav-link dropdown-toggle'
    klass += ' active' if item.selected
    "<li class=\"nav-item dropdown\">
      <a class=\"#{klass}\" href=\"#\" id=\"navbarDropdown\" role=\"button\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">#{@render_name(item.name)}</a>
      <div class=\"dropdown-menu\" aria-labelledby=\"navbarDropdown\">#{(@render_item_a(i) for i in item.items).join('')}
      </div>
    </li>"

  render_item_a: (item) ->
    klass = 'dropdown-item'
    klass += ' active' if item.selected
    item.klass = klass
    @render_link item

  render_item_li: (item) ->
    if item.items
      @render_dropdown(item)
    else
      klass = 'nav-item'
      klass += ' active' if item.selected
      item.klass = 'nav-link'
      "<li class=\"#{klass}\">#{@render_link(item)}</li>"

  render_name: (name) ->
    if typeof name is 'string'
      name
    else
      "<i class=\"fa fa-fw fa-#{name.icon}\"></i>&nbsp;#{name.text}"

  render_link: (item) ->
    if item.name.method
      "<a class=\"#{item.klass}\" href=\"#{item.url}\" data-method=\"#{item.name.method}\">
        #{@render_name item.name}</a>"
    else
      "<a class=\"#{item.klass}\" href=\"#{item.url}\">#{@render_name item.name}</a>"

$(document).on 'turbolinks:load', ->
  navbar = new NavbarBuilder
  navbar.go()
