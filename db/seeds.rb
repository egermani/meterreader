def syllable_factory(symbol)
  sound = symbol.scan(/[A-Z]+/)[0]
  stress = symbol.scan(/\d/)[0]
  syllable = Syllable.find_or_create_by(phone: Phone.find_by(sound: sound), stress: stress)
end


# File.foreach("/Users/admin/cmudict/cmudict-0.7b.phones") do |line|
#   sound, sound_type = line.chomp.split("\t")
#   Phone.create!(sound: sound, sound_type: sound_type)
# end

# File.foreach("/Users/admin/cmudict/cmudict-0.7b.symbols") do |line|
#   syllable_factory(line)
# end

File.foreach("/Users/admin/cmudict/cmudict-0.7b") do |line|
  next if line[0..2] == ';;;'
  begin
    word, syllable_string = line.chomp.split('  ')
    word.encode!('UTF-8', 'UTF-8', :invalid => :replace)
    current_word = Word.new(word: word)
    syllable_strung = syllable_string.split(' ')
    syllable_strung.each_with_index do |symbol, i|
      utter = Utterance.create(syllable: syllable_factory(symbol), start_dist: i, end_dist: syllable_strung.length - i)
      current_word.utterances << utter
    end
    current_word.save
    p current_word.word
  rescue
    p "#{line} was no good, we're moving on"
  end
end