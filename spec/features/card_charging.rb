require_relative '../spec_helper'

describe 'homepage', type: :feature, js: true do
end

describe 'successful charge', type: :feature, js: true do
  it 'works' do
    visit '/'
    fill_in 'email', with: 'validemail@example.com'
    fill_in 'name', with: 'FakeName'
    fill_in 'address', with: '123 Fake St.'
    fill_in 'city', with: 'Seattle'
    fill_in 'state', with: 'WA'
    fill_in 'zip', with: '98109'
    select '2 8oz. bags ($14.00)', from: 'amount'
    fill_in 'Card Number', with: '4242424242424242'
    fill_in 'CVC', with: '222'
    within('.expiry') do
      fill_in 'expiration-month', with: '02'
      fill_in 'expiration-year', with: '2022'
    end
    click_button 'Submit Payment'
    sleep 3
    find('.thank-you') do
      page.should have_content 'Thanks'
      page.should have_content '$14.00'
    end
  end
end


