class LineAnalyzer
  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize(content, line_number)
    @content = content
    @line_number = line_number
    @highest_wf_count = 0
    @highest_wf_words = Array.new(0)

    calculate_word_frequency
  end

  def calculate_word_frequency()
    words = Hash.new(0)
    content.split(' ').each do |word|
      words[word.downcase] += 1
    end

    self.highest_wf_count = words.values.sort.reverse.first

    words.each_pair do |key, value|
      self.highest_wf_words.push(key) if highest_wf_count == value
    end
  end
end

#  Implement a class called Solution. 
class Solution

  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize()
    @analyzers = Array.new(0)
  end

  def analyze_file()
    line_count = 1;
    File.foreach( 'test.txt' ) do |line|
      analyzers.push(LineAnalyzer.new(line, line_count))
      line_count += 1
    end
  end
 
  def calculate_line_with_highest_frequency()
    @highest_count_across_lines = analyzers.sort_by { |analyzer| analyzer.highest_wf_count }.reverse.first.highest_wf_count
    @highest_count_words_across_lines = analyzers.select { |analyzer| @highest_count_across_lines == analyzer.highest_wf_count  }
  end

  def print_highest_word_frequency_across_lines()
    @highest_count_words_across_lines.each do |analyzer| 
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end