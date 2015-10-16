class String

  def to_db
    Word.find_by(word: self.upcase)
  end

end