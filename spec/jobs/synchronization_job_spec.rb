require 'rails_helper'

RSpec.describe SynchronizationJob do
  describe "#perform" do
    it 'calls synchronize service' do
      allow(Synchronize).to receive(:call)

      SynchronizationJob.perform_now

      expect(Synchronize).to have_received(:call)
    end
  end
end
