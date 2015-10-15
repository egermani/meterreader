class Syllable < ActiveRecord::Base
  has_many :utterances
  has_many :words, through: :utterances
  belongs_to :phone
end
