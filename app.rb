require 'rubygems'
require 'sinatra'
require 'stripe'
require 'haml'

<<<<<<< HEAD
Stripe.api_key = "STRIPE_API_PRIVATE_KEY"
set :views, File.dirname(__FILE__) + "/views"

def is_number?(i)
  true if Float(i) rescue false
end

get "/" do
  erb :form
end

post "/pay" do
  if is_number?(params[:amount].to_f)
    amount = ((params[:amount].to_f)*100).to_i
    @charge = Stripe::Charge.create(
      :amount => amount,
      :currency => "usd",
      :card => params[:stripeToken],
      :description => "test payment")
    erb :thanks
  else
    redirect "/"
=======
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
>>>>>>> 09c2c03... Passing capybara test for filling out the form
  end
end
