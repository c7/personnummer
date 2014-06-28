require 'date'

class PersonnummerDate
  attr_reader :year, :month

  def initialize(century, year, month, day, divider)
    @divider = divider
    @day = day
    @month = month
    @year = calculate_century(century, year) + year
  end

  def day
    co_ordination_number? ? @day - 60 : @day
  end

  def co_ordination_number?
    @day && 60 < @day and @day < 92
  end

  def to_date
    Date.parse("#{year}-#{month}-#{day}")
  end

  def valid?
    to_date && true
  end

  def age
    if Date.today > to_date
      (Date.today - to_date).to_i/365
    else
      0
    end
  end

  private

    def calculate_century(century, year)
      # Get the current date
      today = Date.today

      if century == 0
        # Decide which century corresponds to the number
        if year < (today.year-2000) && @divider == '-'
          century = 2000
        elsif year < (today.year-2000) && @divider == '+'
          century = 1900
        elsif @divider == '+'
          century = 1800
        else
          century = 1900
        end
      else
        century *= 100
      end
      return century
    end

end