> [!WARNING]
> **This project is no longer maintained and has been archived.**
>
> The [`personnummer`](https://rubygems.org/gems/personnummer) gem name has been
> handed over to the [personnummer organisation](https://github.com/personnummer),
> which maintains Ruby and other language packages for validating Swedish personal
> identity numbers.
>
> **For new projects, please use [personnummer/ruby](https://github.com/personnummer/ruby):**
>
> ```ruby
> gem "personnummer", "~> 3.0"
> ```
>
> Note that the API has changed — e.g. `Personnummer.valid?("8507099805")` instead
> of `Personnummer.new(...)`. See the [personnummer/ruby README](https://github.com/personnummer/ruby#readme)
> for details.
>
> Versions `~> 0.1` of this gem remain available on RubyGems and will continue to
> work in existing Gemfiles, but will receive no further updates.

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

### Equality

```
>> p1 = Personnummer.new(8304285912)
=> #<Personnummer:0x007fb8fd816588 @valid=true, @control_digit=2, @divider="-", @serial=591, @born=#<Personnummer::Born:0x007fb8fd80fa80 @divider="-", @day=28, @month=4, @year=1983>, @region="Skaraborgs län", @female=false>

>> p1 == 8304285912
=> true
p1 == '8304285912'
=> true
```

### Note on "reservnummer"

"Reservnummer" is used in some special cases. There are only recommendations how it should be formatted, no formalized standard.

You can read more about it on [wikipedia](https://sv.wikipedia.org/wiki/Reservnummer#Format).
