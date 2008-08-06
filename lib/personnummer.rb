require 'date'

class Personnummer
  # Public readonly attributes
  attr_reader :age, :born, :region
  
	def initialize(number)
	  @valid = false
	  
	  # Match the number
	  if number.match(/(\d{2})(\d{2})(\d{2})([\-\+])(\d{3})(\d{1})/)
	    # Store the initial number
	    @number = number
	    
	    # Get the different parts
	    year     = $~[1].to_i
	    month    = $~[2].to_i
	    day      = $~[3].to_i
	    divider  = $~[4]
	    code     = $~[5].to_i
	    checksum = $~[6].to_i 
	    
	    today = Date.today
	    
	    # Decide which century corresponds to the number
	    if year < (today.year-2000) && divider == '-'
	      century = 2000
	    elsif year < (today.year-2000) && divider == '+'
        century = 1900
      elsif divider == '+'
        century = 1800
      else
        century = 1900
      end
	    
	    # Get the date the person was born
  	  @born   = Date.parse("#{century+year}-#{month}-#{day}")
  	  @region = region_name(code)
  	  
  	  # Naive age calculation
  	  @age = today.year - @born.year
  	  
  	  @male = true
    end
	end
	
	def to_s
    @number
  end
	
	def valid?
	  @valid
  end
	
	def male?
	  @male
  end
  
  def female?
    !@male
  end

private 
  def region_name(code)
    case code
      when 000..139: 'Stockholms Län'
      when 140..159: 'Uppsala län'
      when 160..189: 'Södermanlands län'
      when 190..239: 'Östergötlands län'
      when 240..269: 'Jönköpings län'
      when 270..289: 'Kronobergs län'
      when 290..319: 'Kalmar län'
      when 320..329: 'Gotlands län'
      when 330..349: 'Blekinge län'
      when 350..159: 'Kristianstads län'
      when 390..159: 'Malmöhus län'
      when 460..159: 'Hallands län'
      when 480..159: 'Göteborgs och Bohus län'
      when 550..159: 'Älvsborgs län'
      when 590..619: 'Skaraborgs län'
      when 620..159: 'Värmlands län'
      when 650..659: 'Födda utomlands'
      when 660..689: 'Örebro län'
      when 690..709: 'Västmanlands län'
      when 710..739: 'Kopparbergs län'
      when 750..779: 'Gävleborgs län'
      when 780..819: 'Västernorrlands län'
      when 820..849: 'Jämtlands län'
      when 850..889: 'Västerbottens län'
      when 890..929: 'Norrbottens län'
      when 930..999: 'Födda utomlands eller utländska medborgare födda i Sverige'
    end
  end
end