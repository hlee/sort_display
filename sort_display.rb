require 'date'
module SortDisplay

  class Record
    attr_accessor :last_name, :first_name, :middle_initial, :gender, :favorite_color, :date_of_birth, :str

    def initialize h
      h.each{|k,v|send("#{k}=",v)}
    end
    #change date of birth as the date format
    #12/2/1973 => 12/02/1973
    def parse_datetime_string
      dt = String.new
      self.date_of_birth.split('/').each{|x| dt = dt + (x.to_i < 10 ? '0'+ x + '/' : x + "/")}
      self.date_of_birth = DateTime.strptime(dt, "%m/%d/%Y/")
      self
    end
  end

  def self.generate_to_file
    rd = ["Smith Steve Male 3/3/1985 Red\nSeles Monica Female 12/2/1973 Black\nKournikova Anna Female 6/3/1975 Red", "Kelly Sue Female 7/12/1959 Pink\nHingis Martina Female 4/2/1979 Green\nBouillon Francis Male 6/3/1975 Blue","Bonk Radek Male 6/3/1975 Green\nBishop Timothy Male 4/23/1967 Yellow\nAbercrombie Neil Male 2/13/1943 Tan"]
    delimited = ['|',',',' ']
    delimited.each_with_index do |d, i|
      File.open('record' + i.to_s + '.rd','w') do |f|
        f.puts rd[i].gsub(/ /, d)
      end
    end
  end

  def self.load_from_file
    files = Dir.glob('*.rd')
    records = Array.new
    files.each do |f_name|
      f = File.open(f_name,'r')
      f.each do |line|
        tmp = Record.new({})
        tmp.str =  line.gsub(/\|/, ' ').gsub(/,/, ' ')
        tmp.first_name, tmp.last_name ,tmp.gender, tmp.date_of_birth, tmp.favorite_color = tmp.str.split(' ')
        records  << tmp.parse_datetime_string
      end
      f.close
    end
    records
  end

  def self.sort_by records, field, asc_desc
    if asc_desc == 'asc'
      records.sort_by{|x|x.send field}
    elsif asc_desc == 'desc'
      records.sort{|x, y|(y.send field) <=> (x.send field) }
    end
  end
end
=begin
SortDisplay.generate_to_file
records = SortDisplay.load_from_file
rs = SortDisplay.sort_by records, 'date_of_birth', 'asc'
rs.each{|x|puts x.str}
=end