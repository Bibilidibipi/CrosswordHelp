class Anagrams
  attr_reader :dictionary
    
  def initialize
    raw_dictionary = File.readlines('./dictionary.txt', chomp: true)
    @dictionary = Hash.new { |h, k| h[k] = [] }

    raw_dictionary.each do |word|
      next unless alphabetic?(word)
      word = word.downcase.gsub("'", '')
      next if @dictionary[word.length].include?(word)

      @dictionary[word.length] << word
    end
  end

  def print_all_length_anagrams(num_letters)
    all_anagrams = all_length_anagrams(num_letters)
    all_anagrams.select { |a, words| words.length > 1 }.values.each { |anagram| print(anagram, "\n") }
  
    all_anagrams.values.map(&:size).max
  end

  def all_word_anagrams(word)
    return [] unless alphabetic?(word)

    anagrams = []
    dictionary[word.length].each do |test_word|
      anagrams << test_word if is_anagram?(word, test_word)
    end

    anagrams
  end


  private

  def alphabetic?(word)
    word.match?(/\A[A-Za-z']*\z/)
  end

  def is_anagram?(word1, word2)
    alphabetical(word1) == alphabetical(word2)
  end

  def alphabetical(word)
    word.chars.sort.join('')
  end

  def all_length_anagrams(num_letters)
    anagrams = Hash.new { |h, k| h[k] = [] }

    dictionary[num_letters].each do |word|
      anagrams[alphabetical(word)] << word
    end

    anagrams
  end
end
