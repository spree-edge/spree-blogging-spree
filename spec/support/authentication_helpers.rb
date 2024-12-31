# frozen_string_literal: true

module AuthenticationHelpers
  def sign_in_as!(user)
    visit '/login'

    fill_in 'spree_user_email', with: user.email
    fill_in 'spree_user_password', with: 'secret'

    click_button 'Log in'
  end
end
