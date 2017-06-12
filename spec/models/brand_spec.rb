require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe '.create_from_entry' do
    it 'create a Brand record' do
      logo = double(url: 'logo_url_here')
      brand_entry_fields = {
        company_name: "Company name",
        company_description: "Company description",
        website: "http://www.test.com",
        twitter: "https://twitter.com/test",
        email: "test@test.com",
        logo: logo,
        phone: [
          "+45 35 55 44 59"
        ]
      }
      brand_entry = double(fields: brand_entry_fields, id: "abc123")

      expect {Brand.create_from_entry(brand_entry)}.to change{ Brand.count }.by(1)
    end
  end
end
