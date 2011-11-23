require 'test/unit'
require_relative 'sort_display'
require 'minitest/spec'
require 'date'
class SortDisplayTest <  Test::Unit::TestCase
  describe SortDisplay.load_from_file do
    before do
      SortDisplay.generate_to_file
    end

    it "can be created with a specific size" do
      #skip("Need to debug this...")
      SortDisplay.must_respond_to(:load_from_file)
    end

    it "should load record data from file" do
      SortDisplay.load_from_file.first.must_be_instance_of SortDisplay::Record
    end

    it "should read all of the data" do
      SortDisplay.load_from_file.size.must_equal 9
    end

    it "date of birth field should be parsed" do
      SortDisplay.load_from_file.each do |record|
        record.date_of_birth.must_be_instance_of DateTime
      end
    end

    after do
      Dir.glob('*.rd').each{|f| File.delete f}
    end

  end

  describe 'sort by method' do
    arr_list = [
      {:first_name => 'monica', :gender => 'female', :date_of_birth => Date.new(1911,12,3)},
      {:first_name => 'jack', :gender => 'male', :date_of_birth => Date.new(2011,1,30)},
      {:first_name => 'linda', :gender => 'female', :date_of_birth => Date.new(2009,8,1)}
    ]
=begin
  TODO I prefer to use mock instead of creating real SortDisplay::Record. but the way MiniTest::Mock is not the way like flexmock and macha do
=end
    before do
      @records = arr_list.collect{|rd| SortDisplay::Record.new(:first_name => rd[:first_name], :gender => rd[:gender], :date_of_birth => rd[:date_of_birth])}
    end

    it "should sort by gender" do
      SortDisplay.sort_by(@records, 'gender', 'desc').size.must_equal 3
      SortDisplay.sort_by(@records, 'gender', 'asc').first.gender.must_equal 'female'
      SortDisplay.sort_by(@records, 'gender', 'desc').first.must_be_same_as @records.select{|x|x.gender == 'male'}.first
    end

    it "should sort by first name " do
      SortDisplay.sort_by(@records, 'first_name', 'desc').size.must_equal 3
      SortDisplay.sort_by(@records, 'first_name', 'asc').first.must_be_same_as @records.select{|x|x.first_name == 'jack'}.first
      SortDisplay.sort_by(@records, 'first_name', 'desc').first.must_be_same_as @records.select{|x|x.first_name == 'monica'}.first
    end

    it "should sort by date of birth" do
      SortDisplay.sort_by(@records, 'date_of_birth', 'desc').size.must_equal 3
      SortDisplay.sort_by(@records, 'date_of_birth', 'asc').first.date_of_birth.must_equal Date.new(1911,12,3)
      SortDisplay.sort_by(@records, 'date_of_birth', 'desc').first.must_be_same_as @records.select{|x|x.date_of_birth == Date.new(2011,1,30)}.first
    end

  end

end