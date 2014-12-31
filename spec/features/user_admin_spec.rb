require 'rails_helper'

describe User do
  context 'user_admin' do
    let(:user_admin) { create :user_admin }
    before { login_with user_admin.username, user_admin.password }

    context 'creates user' do
      it do
        visit users_path
        click_link 'Nuovo utente locale'

        u = build :user
        %w( username fullname email password ).each do |f|
          fill_in "user_#{f}", with: u.send(f.to_sym)
        end
        fill_in 'user_password_confirmation', with: u.password
        click_button 'Crea utente locale'

        expect(page).to have_content I18n.t('chaltron.users.created')
      end
    end

    context 'updates user' do
     let!(:user) { create :user }
     let!(:admin) { create :admin }
     let!(:user_admin2) { create :user_admin }
      it do
        visit users_path
        # add role to empty set
        click_link user.username
        click_link 'Modifica'
        check :user_roles_admin
        click_button "Modifica #{user.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(user.reload.roles).to eq ['admin']
        click_link 'Indietro'

        # add role to not empty set
        click_link user_admin2.username
        click_link 'Modifica'
        check :user_roles_admin
        click_button "Modifica #{user_admin2.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(user_admin2.reload.roles).to eq ['admin', 'user_admin']
        click_link 'Indietro'

        # remove a role
        click_link admin.username
        click_link 'Modifica'
        uncheck :user_roles_admin
        click_button "Modifica #{admin.username}"
        expect(page).to have_content I18n.t('chaltron.users.updated')
        expect(admin.reload.roles).to eq []
      end

    end
  end
end
