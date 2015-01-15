require 'rails_helper'

describe User do

  context 'user_admin' do
    let(:user_admin) { create :user_admin }
    subject { page }
    context 'creates LDAP user by uid' do
      before { login_with user_admin.username, user_admin.password }
      it 'succeeds', js: true do

        visit users_path

        click_button I18n.t('chaltron.users.index.new_user')

        click_link I18n.t('chaltron.users.index.new_ldap_user')

        fill_in 'userid', with: 'sirius'
        click_button I18n.t('chaltron.ldap.search.submit_text')

#        is_expected.to have_content 'sirius'


#        find('table#ldap_create td.username').click
#        check :user_roles_admin
#        click_button I18n.t('chaltron.ldap.multi_new.submit_text')

#        is_expected.to have_content 'sirius'
#        is_expected.not_to have_css 'div.panel-danger'
      end
    end


 end


end  
