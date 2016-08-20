require 'rails_helper'

RSpec.describe Subscription, type: :model do
  
  describe 'should have usual attributes' do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :newsletter }
    it { is_expected.to respond_to :dev_news }
    it { is_expected.to respond_to :user }
    it { is_expected.to respond_to :user_id }
  end
  
end
