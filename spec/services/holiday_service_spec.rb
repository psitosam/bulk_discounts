require 'rails_helper'

RSpec.describe HolidayService do
  describe 'get url' do
    it 'returns an array of hashes in JSON format' do
      service = HolidayService.new
      expected = service.get_url("https://date.nager.at/api/v3/NextPublicHolidays/us")

      expect(expected).to be_a(Array)
      expect(expected[0]).to be_a(Hash)
    end
  end

  describe 'get_holidays' do
    it 'returns holiday data' do
      service = HolidayService.new
      expected = service.get_url("https://date.nager.at/api/v3/NextPublicHolidays/us")
# require 'pry'; binding.pry
      expect(expected[0][:localName]).to be_a(String)
      expect(expected[0][:date]).to be_a(String)
    end
  end
end
