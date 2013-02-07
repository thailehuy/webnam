require 'time'

class WebnamMailer < ActionMailer::Base

  default :from => "WebNam <noreply@webnam.net.vn>"

  def notify_inquiry_received(from, email,subject,body)
    mail(
        :from => from + " <noreply@webnam.net.vn>",
        :subject => subject,
        :body => body,
        :to   => email
    ).deliver
  end

  def notify_owner_of_inquiry(from, name,email,message,phone,owner)
    mail(
        :from => from + " <noreply@webnam.net.vn>",
        :subject => "You have received an inquiry",
        :body => "From : " + name + "\n\nEmail : " + email + "\n\nPhone : " + phone + "\n\nMessage : " + message + "\n\nDate/Time : " + Time.now.strftime("%Y-%m-%d %H:%M"),
        :to   => owner
    ).deliver
  end

end
