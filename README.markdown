# Personnummer

Personnummer is a ruby class that handles [Swedish personal identity number](http://en.wikipedia.org/wiki/Personal_identity_number_(Sweden)).

### Installation

    $ gem install personnummer

### Example usage

<pre>&gt;&gt; p = Personnummer.new('830428-5912')
#&gt;&gt;Personnummer:0x007fc971369100 @valid=true, @control_digit=2, @divider="-", @serial=591, @born=#&gt;&gt;PersonnummerDate:0x007fc971368318 @divider="-", @day=28, @month=4, @year=1983&gt; #&lt;, @region="Skaraborgs län", @female=false&gt; #&lt;

&gt;&gt; p.valid?
=&gt; true</pre>
</pre>

### This implementation also supports co-ordination numbers

[Information about co-ordination numbers (in swedish)](https://www.skatteverket.se/rattsinformation/reglerochstallningstaganden/meddelanden/2010/meddelanden2010/skvm201003.5.233f91f71260075abe8800024297.html)

These numbers are obtained by adding 60 to the day of the birth date

<pre>
&gt;&gt; p = Personnummer.new('830488-5912')
=&gt; #&lt;Personnummer:0x007fbafd1458d8 @valid=false, @control_digit=2, @divider="-", @serial=591, @born=#&lt;PersonnummerDate:0x007fbafd144af0 @divider="-", @day=88, @month=4, @year=1983&gt;, @region="Skaraborgs län", @female=false&gt;
&gt;&gt; p.born_at
=&gt; #&lt;Date: 1983-04-28 ((2445453j,0s,0n),+0s,2299161j)&gt;
&gt;&gt; p.co_ordination_number?
=&gt; true
</pre>
