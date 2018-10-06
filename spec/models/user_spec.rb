require 'rails_helper'

RSpec.describe User, type: :model do

  context 'Validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:phone_number)}
    it {should validate_presence_of(:birthdate)}
    it {should validate_presence_of(:gender)}
    it {should validate_presence_of(:avatar)}
  end

end
