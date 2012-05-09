class Date
  def prev_week(day = :monday)
    days_into_week = { :monday => 0, :tuesday => 1, :wednesday => 2, :thursday => 3, :friday => 4, :saturday => 5, :sunday => 6}
    result = (self - 7).beginning_of_week + days_into_week[day]
    self.acts_like?(:time) ? result.change(:hour => 0) : result
  end
end
