# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = SimpleNavigation::Renderer::List

  # Specify the class that will be applied to active navigation items.
  # Defaults to 'selected'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that
  # will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name, item| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # If this option is set to true, all item names will be considered as safe (passed through html_safe). Defaults to false.
  # navigation.consider_item_names_as_safe = false

  # Define the primary navigation
  navigation.items do |primary|
    primary.item :news, 'Link 1', home_test1_path,
                 link_html: { icon: 'fas fa-bullhorn' }
    primary.item :concerts, 'Link 2', home_test2_path,
                 link_html: { icon: 'fas fa-chart-line' }
    primary.item :video, 'Link 3', home_test3_path,
                 link_html: { icon: 'fas fa-book' }
    primary.item :info, 'Submenu', '#',
                 link_html: { icon: 'fas fa-hand-point-down' } do |info_nav|
      info_nav.item :main_info_page, 'Link 4', home_test4_path,
                    link_html: { icon: 'fas fa-paw' }
      info_nav.item :about_info_page, 'Link 5', home_test5_path,
                    link_html: { icon: 'fas fa-headphones' }
      info_nav.item :contact_info_page, 'Link 6', home_test6_path,
                    link_html: { icon: 'fas fa-futbol' }
    end
    primary.item :user, 'Link7', home_test7_path,
                 link_html: { icon: 'fas fa-user' }
  end
end
