class CartNotifier < ActionMailer::Base
  default from: "admin@application.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cart_notifier.error.subject
  #
  def error(error_text)
    @error = error_text

    mail to: "cheeerny@rambler.ru", subject: 'Error'
  end
end
