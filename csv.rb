require 'json'
class Chars
  attr_accessor :file, :text, :hash_text

  def initialize(file_name)
    @file = File.open(file_name, 'r')
    @text = @file.read.chomp.downcase.gsub(/[^a-z]/, '')
  end

  def to_hash
    @hash_text = Hash.new(0)
    @text.split('').each do |char|
      @hash_text[char] += 1
    end
    @hash_text
  end

  def count_percent
    @hash_text = to_hash
    number_of_chars = @text.size
    @hash_text.each do |key, value|
      @hash_text[key] = value.to_f / number_of_chars * 100
    end
  end
end

chars = Chars.new(ARGV[0])
result_file = File.open(ARGV[1], 'w')
result_file.puts chars.count_percent.to_json
result_file.close
