class Word < ActiveRecord::Base
  has_many :utterances
  has_many :syllables, through: :utterances
  has_many :sounds

  def self.rhymes?(a, b)
    raise ArgumentError, "#{a} isn't in the database" unless Word.exists?(a.to_db)
    raise ArgumentError, "#{b} isn't in the database" unless Word.exists?(b.to_db)
    if a.length < b.length
      a, b = b, a
    end
    a = a.to_db.pith
    b = b.to_db.pith
    Word.phones(a[-b.length..-1]) == Word.phones(b) && Word.stresses(a[-b.length..-1]) == Word.stresses(b)
  end

  def ordered_syllables
    utterances.order(start_dist: :ASC).map(&:syllable)
  end

  def pith
    ordered_syllables.drop_while {|s| s.stress == nil}
  end

  def self.stresses(syllables=ordered_syllables)
    return syllables.map {|s| s.stress ? true : false}
    # return syllables.map(&:stress)
  end

  def self.phones(syllables=ordered_syllables)
    syllables.map {|s| s.phone.sound}
  end

  def to_s
    utterances.order(start_dist: :ASC).map{ |u| u.syllable.phone.sound + u.syllable.stress.to_s}.join(" ")
  end
end