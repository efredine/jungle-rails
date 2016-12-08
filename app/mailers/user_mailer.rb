class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def welcome_email

    mail(to: 'user@somewhere.com', subject: 'Welcome to My Awesome Site', body: "Not much to say.",
         content_type: "text/html")
  end

  def order_receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Confirmation for Order #{@order.id}")
  end
end
