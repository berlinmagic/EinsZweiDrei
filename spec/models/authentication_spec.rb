require 'rails_helper'

RSpec.describe Authentication, type: :model do
  
  describe 'should have usual attributes' do
    it { is_expected.to respond_to :user }
    
    it { is_expected.to respond_to :uid }
    it { is_expected.to respond_to :provider }
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :link }
    
  end
  
end
