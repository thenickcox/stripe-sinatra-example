require_relative '../spec_helper'

describe 'the application' do
  describe 'homepage', type: :feature, js: true do
  end

  describe 'correct choice selected', type: :feature, js: true do
    context '14' do
      it 'chooses the right select option' do
        visit '/checkout?choice=1400'
        expect(page).to have_select('amount', selected: '2 8oz. bags ($14.00)')
      end
    end
    context '20' do
      it 'chooses the right select option' do
        visit '/checkout?choice=2000'
        expect(page).to have_select('amount', selected: '4 8oz. bags ($20.00)')
      end
    end
  end

  describe 'successful charge', type: :feature, js: true do
    it 'works' do
      visit '/checkout'
      fill_in 'email', with: 'validemail@example.com'
      fill_in 'name', with: 'FakeName'
      fill_in 'address', with: '123 Fake St.'
      fill_in 'city', with: 'Seattle'
      select 'Washington', from: 'state'
      fill_in 'zip', with: '98109'
      select '2 8oz. bags ($14.00)', from: 'amount'
      fill_in 'card-number', with: '4242424242424242'
      fill_in 'cc-cvc', with: '222'
      within('.expiry') do
        select '2', from: 'expiration-month'
        select '2015', from: 'expiration-year'
      end
      click_button 'Place Order'
      find('.thank-you') do
        page.should have_content 'Thanks'
        page.should have_content '$14.00'
      end
    end
  end

  describe 'failed charge', type: :feature, js: true do
    it 'checkout' do
      visit '/checkout'
      click_button 'Place Order'
      page.should have_content 'This card number looks invalid'
    end
  end
end
