# -*- encoding: utf-8 -*-
require 'date'

class Personnummer
  # Public readonly attributes
  attr_reader :born, :region, :control_digit

  def initialize(number)
    @valid = false

    # Match the number
    number = number.to_s
    if number.match(/(\d{2})(\d{2})(\d{2})([\-\+]{0,1})(\d{3})(\d{0,1})/)

      # Calculate the control digit based on the birth date and serial number
      @control_digit = luhn_algorithm("#{$~[1]}#{$~[2]}#{$~[3]}#{$~[5]}")

      # Get the different parts of the number
      year     = $~[1].to_i
      month    = $~[2].to_i
      day      = $~[3].to_i
      @divider  = $~[4]
      @serial   = $~[5].to_i

      # Set default divider if not present
      if @divider.empty?
        @divider = '-'
      end

      # Make the personnummer valid if the checksum is correct
      @valid = true if @control_digit == $~[6].to_i && !$~[6].empty?

      # Get the current date
      today = Date.today

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

      # Get the date the person was born
      @born   = Date.parse("#{century+year}-#{month}-#{day}")

      # Get the region name
      @region = region_name(@serial)

      # Check if the person is female based the serial (even == female)
      @female = (@serial % 2 == 0)
    else
      raise ArgumentError.new, "The supplied personnummer is invalid"
    end
  end

  def age
    if Date.today > @born
      (Date.today - @born).to_i/365
    else
      0
    end
  end

  def to_s
    "%s%s%03d%d" % [@born.strftime("%y%m%d"), @divider, @serial, @control_digit]
  end

  def valid?
    @valid
  end

  def male?
    !@female
  end

  def female?
    @female
  end

private

  def luhn_algorithm(number)
    multiplications = []

    number.split(//).each_with_index do |digit, i|
      if i % 2 == 0
          multiplications << digit.to_i*2
        else
          multiplications << digit.to_i
        end
    end

    sum = 0

    multiplications.each do |number|
      number.to_s.each_byte do |character|
        sum += character.chr.to_i
      end
    end

    if sum % 10 == 0
      control_digit = 0
    else
      control_digit = (sum / 10 + 1) * 10 - sum
    end

    control_digit
  end

  def region_name(code)
    # Don't return a region name if the person was born after 1990
    # (When the previous region code was changed to a serial number)
    if @born.year > 1990
      return ''
    end

    case code
      when 000..139 then 'Stockholms Län'
      when 140..159 then 'Uppsala län'
      when 160..189 then 'Södermanlands län'
      when 190..239 then 'Östergötlands län'
      when 240..269 then 'Jönköpings län'
      when 270..289 then 'Kronobergs län'
      when 290..319 then 'Kalmar län'
      when 320..329 then 'Gotlands län'
      when 330..349 then 'Blekinge län'
      when 350..389 then 'Kristianstads län'
      when 390..459 then 'Malmöhus län'
      when 460..479 then 'Hallands län'
      when 480..549 then 'Göteborgs och Bohus län'
      when 550..589 then 'Älvsborgs län'
      when 590..619 then 'Skaraborgs län'
      when 620..649 then 'Värmlands län'
      when 650..659 then 'Födda utomlands'
      when 660..689 then 'Örebro län'
      when 690..709 then 'Västmanlands län'
      when 710..739 then 'Kopparbergs län'
      when 750..779 then 'Gävleborgs län'
      when 780..819 then 'Västernorrlands län'
      when 820..849 then 'Jämtlands län'
      when 850..889 then 'Västerbottens län'
      when 890..929 then 'Norrbottens län'
      when 930..999 then 'Födda utomlands eller utländska medborgare födda i Sverige'
    end
  end
end
