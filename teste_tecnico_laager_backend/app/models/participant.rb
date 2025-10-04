class Participant < ApplicationRecord
  has_many :votes

  # atributo para fazer ordenação por maiores votos
  scope :order_by_higher_total_votes, -> {
    left_joins(:votes)
      .group('participants.id')
      .select('participants.*, COUNT(votes.id) AS votes_count')
      .order('votes_count DESC')
  }
  scope :order_by_name, -> { order(name: :asc) }
end
