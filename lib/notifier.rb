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
     text: "Dear #{first_name}, \n\nThank you so much for your order. You'll receive another email from us in the coming days regarding the next roast you'll receive and when to expect it. We can't wait to share this coffee with you! If you need anything at all, please let us know at info@slowcoffee.co, or feel free to reply to this email.\n\nLove & Coffee,\nNick & Dan\n\nPS -- Refer a friend, and we'll bump you up to 12oz. bags as a way to say thank you. Were you referred by someone? Let us know at info@slowcoffee.co.",
     to: [
       {
         email: opts[:email],
         name: opts[:name]
       }
     ],
     from_email: 'nick@slowcoffee.co'
    }
    sending = m.messages.send message
    puts sending
  end
end

