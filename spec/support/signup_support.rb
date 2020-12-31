module SignupSupport
  def sign_up_as(user)
    visit sign_up_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    find_button('SignUp').click
  end
end

RSpec.configure do |config|
  config.include SignupSupport
end
