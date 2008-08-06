# Real world scripts would use:
# require 'rubygems'
# require 'personnummer'
#
# Instead of:
require 'lib/personnummer'

p = Personnummer.new('830428-5912')

puts "valid?: #{p.valid?}"
puts "age: #{p.age}"
puts "born.year: #{p.born.year}"
puts "region: #{p.region}"
puts "male?: #{p.male?}"
puts "to_s: #{p}"