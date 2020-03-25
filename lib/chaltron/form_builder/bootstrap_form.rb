class BootstrapForm::FormBuilder

  def role_select(opts = {})
    collection = Role.all.map { |role| [role.id, I18n.translate("roles.#{role.name}")] }

    checked_ids = @object.nil?? false : @object.roles.map(&:id)
    disabled_id = opts[:disabled].blank? ? nil : Role.find_by_name(opts[:disabled]).id

    html = inputs_collection(:role_ids, collection, :first, :last, checked: checked_ids) do |name, value, options|
      options[:multiple] = true
      options[:custom]   = opts.fetch(:custom, true)
      options[:inline]   = opts.fetch(:inline, true)
      options[:disabled] = true if value == disabled_id

      check_box(name, options, value, nil)
    end

    hidden = disabled_id || ''
    hidden_field(:role_ids, { value: hidden, multiple: true }).concat(html)
  end

end
