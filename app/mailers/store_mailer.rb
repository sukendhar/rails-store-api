class StoreMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def new_store_notify(store)
    @store = store
    mail(to: "admin@example.com", subject: "A new store has been created")
  end
end
