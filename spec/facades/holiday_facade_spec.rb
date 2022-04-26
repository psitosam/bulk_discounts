require 'rails_helper'

RSpec.describe HolidayFacade do

  describe 'service' do
    it 'returns a holiday service object' do
      facade = HolidayFacade.new

      expect(facade.service).to be_a(HolidayService)
    end
  end
end
