class BootstrapForm::FormBuilder

  def role_select
    collection = Chaltron.roles.map {|role| [ role, I18n.translate("roles.#{role}") ] }
    html = inputs_collection(:roles, collection, :first, :last, checked: @object.roles) do |name, value, options|
      options[:multiple] = true
      options[:inline] = true
      check_box(name, options, value, nil)
    end
    hidden_field(:roles,{value: '', multiple: true}).concat(html)
  end

end
