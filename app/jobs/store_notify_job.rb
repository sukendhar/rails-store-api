class StoreNotifyJob < ApplicationJob
  queue_as :store_notification

  def perform(store_id)
    store = Store.find(store_id)
    StoreMailer.new_store_notify(store).deliver_now
  end
end
