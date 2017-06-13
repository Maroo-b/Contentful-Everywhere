class SynchronizationJob < ApplicationJob
  queue_as :default

  def perform(initial: false)
    Synchronize.call(initial: initial)
  end
  
end
