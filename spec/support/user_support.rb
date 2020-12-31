module UserSupport
  def sign_up_as(user)
    visit sign_up_path
    fill_form_info(user)
    find_button('SignUp').click
  end

  def sign_in_as(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find_button('Login').click
  end

  def fill_edit_user_info(user)
    fill_form_info(user)
    find_button('Update').click
  end

  private

  def fill_form_info(user)
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
  end
end

RSpec.configure do |config|
  config.include UserSupport
end
