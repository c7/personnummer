require 'spec_helper'
require 'personnummer'

describe Personnummer do
  describe "initialize" do
    it "accepts a valid personnummer" do
      expect{ Personnummer.new(8304285912) }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('830428-5912') }.not_to raise_error(ArgumentError)
      expect{ Personnummer.new('050428+5912') }.not_to raise_error(ArgumentError)
    end

    it "throws ArgumentError on an invalid personnummer" do
      expect{ Personnummer.new(nil) }.to raise_error(ArgumentError)
      expect{ Personnummer.new(17) }.to raise_error(ArgumentError)
      expect{ Personnummer.new('112233-4455') }.to raise_error(ArgumentError)
    end
  end

  describe "age" do
    xit "works" do
    end
  end

  describe "born" do
    xit "works" do
    end
  end

  describe "region" do
    xit "works" do
    end
  end

  describe "control_digit" do
    xit "works" do
    end
  end

  describe "to_s" do
    xit "works" do
    end
  end

  describe "valid?" do
    xit "works" do
    end
  end

  describe "male?" do
    xit "works" do
    end
  end

  describe "female?" do
    xit "works" do
    end
  end
end
