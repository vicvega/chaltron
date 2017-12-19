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
    "<a class=\"#{klass}\" href=\"#{item.url}\">#{@render_name item.name}</a>"

  render_item_li: (item) ->
    if item.items
      @render_dropdown(item)
    else
      name = @render_name item.name
      if item.selected
        "<li class=\"nav-item active\">
          <a class=\"nav-link\" href=\"#{item.url}\">#{name}
          <span class=\"sr-only\">(current)</span>
          </a>
        </li>"
      else
        "<li class=\"nav-item\">
          <a class=\"nav-link\" href=\"#{item.url}\">#{name}</a>
        </li>"

  render_name: (name) ->
    if typeof name is 'string'
      name
    else
      "<i class=\"fa fa-fw fa-#{name.icon}\"></i>&nbsp;#{name.text}"

$(document).on 'turbolinks:load', ->
  navbar = new NavbarBuilder
  navbar.go()
