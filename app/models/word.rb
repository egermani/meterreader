class Word < ActiveRecord::Base
  has_many :utterances
  has_many :syllables, through: :utterances
end
