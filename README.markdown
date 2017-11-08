# Personnummer

Personnummer is a ruby class that handles [Swedish personal identity number](http://en.wikipedia.org/wiki/Personal_identity_number_(Sweden)).

### Installation

    $ gem install personnummer

### Example usage

```
>> p = Personnummer.new('830428-5912')
#>>Personnummer:0x007fc971369100 @valid=true, @control_digit=2, @divider="-", @serial=591, @born=#>>PersonnummerDate:0x007fc971368318 @divider="-", @day=28, @month=4, @year=1983> #<, @region="Skaraborgs län", @female=false> #<

>> p.valid?
=> true

>> p = Personnummer.new('830428')
=> ArgumentError: The supplied personnummer is invalid
```

### This implementation also supports co-ordination numbers

[Information about co-ordination numbers (in swedish)](https://www.skatteverket.se/rattsinformation/reglerochstallningstaganden/meddelanden/2010/meddelanden2010/skvm201003.5.233f91f71260075abe8800024297.html)

These numbers are obtained by adding 60 to the day of the birth date

```
>> p = Personnummer.new('830488-5912')
=> #<Personnummer:0x007fbafd1458d8 ...>
>> p.born
=> #<Date: 1983-04-28 ((2445453j,0s,0n),+0s,2299161j)>
>> p.co_ordination_number?
=> true
```

### Note on "reservnummer"

"Reservnummer" is used in some special cases. There are only recommendations how it should be formatted, no formalized standard.

You can read more about it on [wikipedia](https://sv.wikipedia.org/wiki/Reservnummer#Format).
