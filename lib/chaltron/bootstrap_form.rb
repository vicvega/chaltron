class BootstrapForm::FormBuilder

  def role_select(opts={})
    collection = Chaltron.roles.map {|role| [ role, I18n.translate("roles.#{role}") ] }
    checked = @object.nil?? false : @object.roles
    html = inputs_collection(:roles, collection, :first, :last, checked: checked) do |name, value, options|
      options[:multiple] = true
      options[:inline] = true

      if value == opts[:disabled]
        options[:disabled] = true
        options[:checked] = true
      end
      check_box(name, options, value, nil)
    end

    hidden = opts[:disabled] || ''
    hidden_field(:roles,{value: hidden, multiple: true}).concat(html)
  end

end
