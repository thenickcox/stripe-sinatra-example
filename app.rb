require 'json'
require 'sinatra'
require 'stripe'
require 'stripe_event'
require 'haml'
require 'logger'
require 'money'
require 'dotenv'
require 'mandrill'
require 'rack/ssl-enforcer'


require_relative 'lib/notifier'

class App < Sinatra::Base
  Dotenv.load
  Stripe.api_key = ENV['STRIPE_API_KEY']

  configure :production do
    set :host, 'slowcoffee.herokuapp.com'
    set :force_ssl, true
    use Rack::SslEnforcer
  end

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
    Thread.new { Notifier.new.deliver(email: params[:email], name: params[:name], amount: params[:amount]) }
    haml :confirmation
  end

  #post '/_billing_events' do
    #data = JSON.parse(request.body.read, symbolize_names: true)
    #p data
    #StripeEvent.instrument(data)
    #puts "Received event with ID: #{data[:id]} Type: #{data[:type]}"


    ## Retrieving the event from the Stripe API guarantees its authenticity
    #event = Stripe::Event.retrieve(data[:id])

    ## This will send receipts on succesful invoices
    ## You could also send emails on all charge.succeeded events
    #if event.type == 'invoice.payment_succeeded'
     #email_invoice_receipt(event.data.object)
    #end
  #end
end

