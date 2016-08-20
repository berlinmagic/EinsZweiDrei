require 'rails_helper'

RSpec.describe Feedback, type: :model do
  
  describe 'should have usual attributes' do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :subject }
    it { is_expected.to respond_to :content }
    
    it { is_expected.to respond_to :current_controller }
    it { is_expected.to respond_to :current_action }
    it { is_expected.to respond_to :current_params }
    
    it { is_expected.to respond_to :user }
    it { is_expected.to respond_to :user_id }
  end
  
end
