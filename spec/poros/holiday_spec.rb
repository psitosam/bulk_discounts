require 'rails_helper'

RSpec.describe Holiday do
  describe 'attributes' do
    it 'has a name and a date' do
      data = {name: "Memorial Day", date: "2022-05-30" }
      memorial_day = Holiday.new(data)

      expect(memorial_day.name).to eq("Memorial Day")
      expect(memorial_day.date).to eq("2022-05-30")
    end
  end
end
