require 'chaltron/ldap/person'

class Chaltron::LdapController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create_user

  default_log_category :user_admin

  def search
    @limit = default_limit
  end

  def multi_new
    @entries = []
    userid     = params[:userid]
    department = params[:department]
    name       = params[:fullname]
    limit      = params[:limit].to_i
    if userid.present?
      entry = Chaltron::LDAP::Person.find_by_uid(userid)
      @entries << entry unless entry.nil?
    else
      opts = {}
      opts[:department] = "*#{department}*" unless department.blank?
      opts[:cn]         = "*#{name}*"       unless name.blank?
      opts[:limit]      = limit.zero? ? default_limit : limit

      res = Chaltron::LDAP::Person.find_by_fields(opts)
      @entries = res
    end
  end

  def multi_create
    @created = []
    @error   = []
    uids = params[:uids] || []
    uids.each do |uid|
      user = Chaltron::LDAP::Person.find_by_uid(uid).create_user(params[:user][:roles])
      if user.new_record?
        @error << user
      else
        @created << user
      end
    end
    info I18n.t('chaltron.logs.users.ldap_created',
        current: current_user.display_name, count: @created.size,
        user: @created.map(&:display_name).join(', ')) if @created.size > 0
  end

  private
  def default_limit
    100
  end

  def authorize_create_user
    authorize! :create, User
  end

end
