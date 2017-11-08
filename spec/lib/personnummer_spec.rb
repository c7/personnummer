# -*- encoding: utf-8 -*-
require 'spec_helper'
require 'personnummer'
require 'timecop'

describe Personnummer do
  describe "initialize" do
    it "accepts a valid personnummer (with control digit)" do
      expect{ Personnummer.new(9001010017) }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('900101-0017') }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('100101+0017') }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('19900101-0017') }.not_to raise_error(ArgumentError)
    end

    it "accepts a valid personnummer (without control digit)" do
      expect{ Personnummer.new(900101001) }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('900101-001') }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('100101+001') }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('19900101-001') }.not_to raise_error(ArgumentError)
    end

    it "throws ArgumentError on an invalid personnummer" do
      expect{ Personnummer.new(nil) }.to raise_error(ArgumentError)
      expect{ Personnummer.new(17) }.to raise_error(ArgumentError)
      expect{ Personnummer.new('112233-4455') }.to raise_error(ArgumentError)
      expect{ Personnummer.new('19112233-4455') }.to raise_error(ArgumentError)
    end
  end

  describe "age" do
    it "calculates age correctly" do
      p = Personnummer.new('900101-001')
      p2 = Personnummer.new('19900101-001')

      Timecop.freeze(Date.parse('1980-01-01')) do
        p.age.should == 0
        p2.age.should == 0
      end

      Timecop.freeze(Date.parse('1990-01-01')) do
        p.age.should == 0
        p2.age.should == 0
      end

      Timecop.freeze(Date.parse('2000-01-01')) do
        p.age.should == 10
        p2.age.should == 10
      end

      Timecop.freeze(Date.parse('2090-01-01')) do
        p.age.should == 100
        p2.age.should == 100
      end
    end
  end

  describe "born" do
    it "returns the correct date" do
      Timecop.freeze(Date.parse('2010-01-01')) do
        Personnummer.new('900101-001').born.should == Date.parse('1990-01-01')
        Personnummer.new('010101-001').born.should == Date.parse('2001-01-01')
        Personnummer.new('100101+001').born.should == Date.parse('1810-01-01')
        Personnummer.new('19900101-001').born.should == Date.parse('1990-01-01')
        Personnummer.new('18900101-001').born.should == Date.parse('1890-01-01')
      end
    end
  end

  describe "region" do
    it "returns '' for persons born on or after 1991-01-01" do
      Personnummer.new('910101-001').region.should == ''
    end

    it "returns the correct region for persons born before 1991-01-01" do
      it_maps_range_to_region 000..139, 'Stockholms Län'
      it_maps_range_to_region 140..159, 'Uppsala län'
      it_maps_range_to_region 160..189, 'Södermanlands län'
      it_maps_range_to_region 190..239, 'Östergötlands län'
      it_maps_range_to_region 240..269, 'Jönköpings län'
      it_maps_range_to_region 270..289, 'Kronobergs län'
      it_maps_range_to_region 290..319, 'Kalmar län'
      it_maps_range_to_region 320..329, 'Gotlands län'
      it_maps_range_to_region 330..349, 'Blekinge län'
      it_maps_range_to_region 350..389, 'Kristianstads län'
      it_maps_range_to_region 390..459, 'Malmöhus län'
      it_maps_range_to_region 460..479, 'Hallands län'
      it_maps_range_to_region 480..549, 'Göteborgs och Bohus län'
      it_maps_range_to_region 550..589, 'Älvsborgs län'
      it_maps_range_to_region 590..619, 'Skaraborgs län'
      it_maps_range_to_region 620..649, 'Värmlands län'
      it_maps_range_to_region 650..659, 'Födda utomlands'
      it_maps_range_to_region 660..689, 'Örebro län'
      it_maps_range_to_region 690..709, 'Västmanlands län'
      it_maps_range_to_region 710..739, 'Kopparbergs län'
      it_maps_range_to_region 750..779, 'Gävleborgs län'
      it_maps_range_to_region 780..819, 'Västernorrlands län'
      it_maps_range_to_region 820..849, 'Jämtlands län'
      it_maps_range_to_region 850..889, 'Västerbottens län'
      it_maps_range_to_region 890..929, 'Norrbottens län'
      it_maps_range_to_region 930..999, 'Födda utomlands eller utländska medborgare födda i Sverige'
    end
  end

  describe "control_digit" do
    it "responds with the right control digit" do
      Personnummer.new(9001010017).control_digit.should == 7
      Personnummer.new('900101-0017').control_digit.should == 7
      Personnummer.new('900101-001').control_digit.should == 7
    end

    it "should not alter existing control digit, even if it is invalid" do
      p = Personnummer.new("901010-0010")
      p.to_s.should == "901010-0010"
      p.should_not be_valid
    end
  end

  describe "to_s" do
    it "uses the standard string representation" do
      Personnummer.new(9001010017).to_s.should == '900101-0017'
      Personnummer.new('900101-0017').to_s.should == '900101-0017'
      Personnummer.new('900101-001').to_s.should == '900101-0017'
      Personnummer.new('19900101-001').to_s.should == '900101-0017'
      Personnummer.new('18900101-001').to_s.should == '900101-0017'
      Personnummer.new('7010632391').to_s.should == '701063-2391' # Samordningsnummer
    end
  end

  describe "valid?" do
    it "marks a valid personnummer with control digit as valid" do
      Personnummer.new('900101-0017').should be_valid
    end

    it "marks a valid personnummer without control digit as invalid" do
      Personnummer.new('900101-001').should_not be_valid
    end

    it "throws ArgumentError on an invalid personnummer" do
      expect{ Personnummer.new('112233-4455') }.to raise_error(ArgumentError)
    end
  end

  describe "gender" do
    it "recognizes males" do
      Personnummer.new('900101-001').should be_male
      Personnummer.new('900101-003').should be_male
      Personnummer.new('900101-005').should be_male
      Personnummer.new('900101-007').should be_male
      Personnummer.new('900101-009').should be_male
    end

    it "recognizes females" do
      Personnummer.new('900101-000').should be_female
      Personnummer.new('900101-002').should be_female
      Personnummer.new('900101-004').should be_female
      Personnummer.new('900101-006').should be_female
      Personnummer.new('900101-008').should be_female
    end
  end

  describe "co-ordination number" do
    it "should accept a samordningsnummer" do
      Personnummer.new('701063-2391').should be_valid
    end
    it "should not accept an invalid samordningsnummer with less than 62" do
      Personnummer.new('900161-0017').should_not be_valid
    end
    it "should not accept an invalid samordningsnummer with more than 90" do
      Personnummer.new('900191-0017').should_not be_valid
    end
  end

  describe "equality" do
    it "true when equal" do
      personummer1 = Personnummer.new('900101-001')
      personummer2 = Personnummer.new('900101-001')
      (personummer1 == personummer2).should == true
    end

    it "true when equal and passed equal string" do
      personummer1 = Personnummer.new('900101-001')
      (personummer1 == '900101-001').should == true
    end

    it "true when equal and passed equal integer" do
      personummer1 = Personnummer.new('900101-001')
      (personummer1 == 900101001).should == true
    end

    it "false non-equal objects" do
      personummer1 = Personnummer.new('900101-001')
      personummer2 = Personnummer.new('900101-002')
      (personummer1 == personummer2).should == false
    end
  end

  def it_maps_range_to_region(range, region)
    Personnummer.new('901231-%03d' % range.first).region.should == region
    Personnummer.new('901231-%03d' % range.last).region.should == region
  end
end
