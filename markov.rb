class Markov
  attr_accessor :gram_table

  def initialize
    @gram_table = {}
  end

  def generate_table_from_file filepath, grams
    words = File.read(filepath).split(" ")
    @gram_table["NON_WORD NON_WORD"] = [words[0]]
    @gram_table["NON_WORD #{words[0]}"] = [words[1]]

    words.each_cons(grams+1) do |word_group|
      key = word_group[0..grams-1].join(" ")
      value = word_group[grams]
      if @gram_table.has_key? key
        @gram_table[key] << value
      else
        @gram_table[key] = [value]
      end
    end
  end

  def generate_text
    text_array = []
    first_word = @gram_table["NON_WORD NON_WORD"].sample
    text_array << first_word
    text_array << @gram_table["NON_WORD #{first_word}"].sample

    while text_array.size < 400
      next_word = @gram_table["#{text_array[-2]} #{text_array[-1]}"].sample
      text_array << next_word
    end

    File.open("output", 'w') { |file| file.write(text_array) }
    return text_array.join(" ")
  end
end

markov = Markov.new
markov.generate_table_from_file "naruto_wiki", 2
p markov.generate_text
