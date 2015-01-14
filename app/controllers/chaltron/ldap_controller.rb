require 'chaltron/ldap/person'

class Chaltron::LdapController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_create_user

  def search
    @limit = default_limit
  end

  def new
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

  def create
  end

  private
  def default_limit
    100
  end

  def authorize_create_user
    authorize! :create, User
  end

end
