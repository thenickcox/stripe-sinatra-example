require 'rubygems'
require 'sinatra'
require 'stripe'
require 'haml'

Stripe.api_key = "sk_test_AzK176W5YbWlpbJIQR8VXRNU"
set :views, File.dirname(__FILE__) + "/views"

class App < Sinatra::Base

  get "/" do
    haml :form
  end

  post "/pay" do
    amount = params[:amount].to_i
    Stripe::Customer.create(
      email: params[:email],
      metadata: {
        name: params[:name],
        address: params[:address],
        city: params[:city],
        state: params[:state],
        zip: params[:zip]
      }
    )
    @charge = Stripe::Charge.create(
      amount: amount,
      currency: "usd",
      card: params[:stripeToken],
      description: "test payment"
    )
    haml :thanks
  end
end
