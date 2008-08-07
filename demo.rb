# Real world scripts would use:
# require 'rubygems'
# require 'personnummer'
#
# Instead of:
require 'lib/personnummer'

# Valid personnummer
p = Personnummer.new(8304285912)
designation = (p.male?) ? 'His' : 'Her'
puts "#{designation} control digit is: #{p.control_digit}"

if p.valid?
  designation = (p.male?) ? 'He' : 'She'
  puts "#{designation} was born in #{p.region} aproximately #{p.age} years ago" if p.region
end

# Incomplete personnummer
p = Personnummer.new('870312-594')
designation = (p.male?) ? 'His' : 'Her'
puts "#{designation} control digit is: #{p.control_digit}"
