class HolidayFacade

  def next_three_holidays
    holiday_data[0..2].map do |hol_dat|
      Holiday.new(hol_dat)
    end 
  end

  def holiday_data
    @_holiday_data ||= service.get_holidays
  end

  def service
    @_service ||= HolidayService.new
  end

end
