require 'rubygems'
require 'bundler/setup'
require 'mandrill'

class Notifier

  def deliver(opts = {})
    m = Mandrill::API.new
    first_name = opts[:name].split(' ').first
    message = {
     subject: 'Slow Coffee Thanks You!',
     from_name: 'Slow Coffee',
     text: "Dear #{first_name}, \n\n Yippie!  It worked!  We got your order and you're going to get some Slow Coffee! \n\n Thank you so much.  We're deeply grateful for your support. \n\n You'll receive another email from us in the coming days about pick-up or shipping date (depending on your delivery choice). \n\n We can't wait to share this coffee with you! If you need anything at all, please let us know at info@slowcoffee.co, or feel free to reply to this email. \n\n Love & Coffee, \n Nick & Dan",
     to: [
       {
         email: opts[:email],
         name: opts[:name]
       }
     ],
     from_email: 'info@slowcoffee.co'
    }
    sending = m.messages.send message
    puts sending
  end
end

