require 'sinatra'
require 'stripe'
require 'haml'
require 'logger'
require 'money'
require 'dotenv'
require 'mandrill'

Stripe.api_key = "sk_test_AzK176W5YbWlpbJIQR8VXRNU"

class App < Sinatra::Base

  set :root, File.dirname(__FILE__)
  set :views, 'views'
  set :public_folder, 'public'

  get '/' do
    haml :index
  end

  get '/checkout' do
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
      description: "Slow Coffee"
    )
    haml :confirmation
  end
end
