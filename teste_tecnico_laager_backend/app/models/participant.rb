class Participant < ApplicationRecord
  has_many :votes

  # atributo para fazer ordenação por maiores votos
  scope :order_by_higher_total_votes, -> {
    left_joins(:votes)
      .group(:id)
      .select('participants.*, COUNT(votes.id) AS votes_count')
      .order(votes_count: :desc)
  }
  scope :order_by_name, -> { order(name: :asc) }

  # atributo para fazer ordenação por maiores votos
  scope :select_id_name_and_total_votes, -> {
    joins(:votes)
      .group(:id, :name)
      .select('participants.id, participants.name, COUNT(votes.id) AS votes_count')
  }
end
