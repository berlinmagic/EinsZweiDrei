require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'should have usual attributes' do
    ## User
    it { is_expected.to respond_to :last_name }
    it { is_expected.to respond_to :first_name }
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :gender }
    it { is_expected.to respond_to :image }
    
    ## Admin
    it { is_expected.to respond_to :is_wizard }
    it { is_expected.to respond_to :is_master_wizard }
    
    ## if signed_up via service
    it { is_expected.to respond_to :tmp_password }
    
    ## User - Tracking
    it { is_expected.to respond_to :signup_via }
    it { is_expected.to respond_to :signup_url }
    
    ## API-Access
    it { is_expected.to respond_to :api_auth_token }
    
    ## ???
    it { is_expected.to respond_to :birthday }
    it { is_expected.to respond_to :phone }
  end
  
  describe 'should have devise attributes' do
    it { is_expected.to respond_to :email }
    it { is_expected.to respond_to :password }
    it { is_expected.to respond_to :confirmed? }
  end
  
  describe 'should have authentication attributes' do
    it { is_expected.to respond_to :authentications }
  end
  
  describe "should have associations" do
    it { is_expected.to have_many(:authentications).dependent(:destroy) }
    it { is_expected.to have_one(:subscription) }
    it { is_expected.to have_many(:feedbacks) }
  end
  
  describe 'validations' do 
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end
  
  
  describe '.. email stuff ..' do
    
    describe "Email-Format" do
      
      let(:user) { build(:user) }
      
      subject { user }
      
      it { is_expected.to be_valid }
      
      describe "when no email given" do
        it "should be invalid" do
          user.email = ""
          expect(user).not_to be_valid
        end
      end
    
      describe "when email format is invalid" do
        it "should be invalid" do
          addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar@baz.com]
          addresses.each do |invalid_address|
            # puts invalid_address
            user.email = invalid_address
            expect(user).not_to be_valid
          end
        end
      end
    
      describe "when email format is valid but no password" do
        it "should be not valid" do
          addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          addresses.each do |valid_address|
            user.email = valid_address
            expect(user).to be_valid
          end
        end
      end
      
    end
    describe "Email-Excistance" do
      
      let(:user) { build(:user) }
      
      subject { user }
      
      describe "when email address is already taken" do
        before do
          user_with_same_email = user.dup
          user_with_same_email.save
        end
        it { is_expected.not_to be_valid }
      end
      
      describe "when email address is already taken, even different case" do
        before do
          user_with_same_email = user.dup
          user_with_same_email.email = user.email.upcase
          user_with_same_email.save!
        end
        it { should_not be_valid }
        it "should absolutly not be valid" do
          # => puts @user.valid?
          expect( user.valid? ).to be( false )
        end
      end
      
    end
  end
  
  describe '.. password stuff ..' do
    
    let(:user) { build(:user, password: nil) }
    
    subject { user }
    
    describe "no password given" do
      it "should not be valid" do
        expect(user).not_to be_valid
      end
    end
    
    describe "to short password " do
      it "should not be valid" do
        user.password = "23f"
        expect(user).not_to be_valid
      end
    end
    
    describe "to long password " do
      it "should not be valid" do
        user.password = "23f3454212323f3454212323f3454212323f3454212323f3454212323f3454212323f34542123"
        expect(user).not_to be_valid
      end
    end
    
  end
  
end
