# Personnummer

Personnummer is a ruby class that handles [Swedish personal identity number](http://en.wikipedia.org/wiki/Personal_identity_number_(Sweden\)).

### Installation

    $ gem install personnummer

### Example usage

<pre>&gt;&gt; p = Personnummer.new('830428-5912')
=&gt; #&lt;Personnummer:0x301128 @number="830428-5912", @age=25, @valid=true, @region="Skaraborgs l\303\244n",
@male=true, @born=#&lt;Date: 4890905/2,0,2299161&gt;&gt;
&gt;&gt; p.valid?
=&gt; true</pre>
