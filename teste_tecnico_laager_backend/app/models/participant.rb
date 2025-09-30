class Participant < ApplicationRecord
  # atributo para fazer ordenação por maiores votos
  scope :order_by_higher_total_votes, -> { order(total_votes: :desc) }
  scope :order_by_name, -> { order(name: :asc) }
  scope :sum_total_votes, -> { sum(:total_votes) }
  scope :select_only_name_and_total_votes, -> { select(:name, :total_votes) }
end
