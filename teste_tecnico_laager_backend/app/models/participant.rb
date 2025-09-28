class Participant < ApplicationRecord
  # atributo para fazer ordenação por maiores votos
  scope :order_by_higher_total_votes, -> { order(total_votes: :desc) }
  scope :sum_total_votes, -> { sum(:total_votes) }
end
