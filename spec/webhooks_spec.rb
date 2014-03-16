require 'spec_helper'

describe 'email receipt' do
end


#describe "Billing Events" do
  #def stub_event(fixture_id, json_file = nil)
    #json_file ||= fixture_id
    #stub_request(:get, "https://api.stripe.com/v1/events/#{fixture_id}").
      #to_return(:status => 200, :body => '{"id"=>"evt_customer_created", "created"=>1384544738, "livemode"=>false, "type"=>"customer.created", "data"=>{"object"=>{"object"=>"customer", "created"=>1384544738, "id"=>"cus_2wm5EgmRGEiyPO", "livemode"=>false, "description"=>"id:12345", "email"=>"user@example.com", "delinquent"=>false, "metadata"=>{}, "subscription"=>nil, "discount"=>nil, "account_balance"=>0, "cards"=>{"object"=>"list", "count"=>0, "url"=>"/v1/customers/cus_2wm5EgmRGEiyPO/cards", "data"=>[]}, "default_card"=>nil, "next_recurring_charge"=>nil, "active_card"=>nil}}, "object"=>"event", "pending_webhooks"=>1, "request"=>"iar_2wm5M67yu99gVP"}')
  #end

  #describe "customer.created" do
    #before do
      #stub_event 'evt_customer_created'
    #end

    #it "is successful" do
      #post '/_billing_events', id: 'evt_customer_created'
      #p last_response
      #last_response.should be_ok
      ##expect(Notifier).to_recieve(:deliver)
    #end
  #end
#end
