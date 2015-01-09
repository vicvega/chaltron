require 'rails_helper'

describe User do
  context 'user_admin' do
    let(:user_admin) { create :user_admin }
    before { login_with user_admin.username, user_admin.password }

    context 'creates user' do
      it 'succeeds' do
        visit users_path
        click_link 'New local user'

        u = build :user
        %w( username fullname email password ).each do |f|
          fill_in "user_#{f}", with: u.send(f.to_sym)
        end
        fill_in 'user_password_confirmation', with: u.password
        click_button 'Create local user'

        expect(page).to have_content I18n.t('chaltron.users.created')
      end
    end

    context 'updates user' do
     let!(:user) { create :user }
     let!(:admin) { create :admin }
     let!(:user_admin2) { create :user_admin }
      it 'succeeds' do
        visit users_path
        # add role to empty set
        click_link user.username
        click_link 'Edit'
        check :user_roles_admin
        click_button "Edit #{user.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(user.reload.roles).to eq ['admin']
        click_link 'Back'

        # add role to not empty set
        click_link user_admin2.username
        click_link 'Edit'
        check :user_roles_admin
        click_button "Edit #{user_admin2.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(user_admin2.reload.roles).to eq ['admin', 'user_admin']
        click_link 'Back'

        # remove a role
        click_link admin.username
        click_link 'Edit'
        uncheck :user_roles_admin
        click_button "Edit #{admin.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(admin.reload.roles).to eq []
      end
    end

    context 'updates himself' do
      it 'cannot remove user_admin role' do
        visit users_path

        click_link user_admin.username
        click_link 'Edit'
        uncheck :user_roles_admin
        click_button "Edit #{user_admin.username}"

        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(user_admin.reload.roles).to eq ['user_admin']
      end
    end
  end
end
