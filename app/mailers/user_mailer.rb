class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_receipt_email(order)
    @order = order
    mail(to: @order.email, subject: "Confirmation for Order ##{@order.id}")
  end
end
