module Statistics
  def statistics_data
    # obtendo todos os participantes
    participants = Participant.all

    # obtendo o todos os votos ordenados por criação (baixo para cima)
    votes = Vote.all.order_by_creation

    # contanto os votos
    total_votes = votes.count

    # caso base, se ainda não há nenhum voto
    return {
      total_votes: 0,
      votes_per_hour: 0,
      participants: [],
    } if votes.empty?

    # obtendo timestamp do primeiro valor (primeiro voto feito)
    # e ultimo valor (ultimo voto feito até o momento)
    first_vote_timestamp = votes.first.created_at.to_i
    last_vote_timestamp = votes.last.created_at.to_i

    # segundos decorridos desde o primeiro voto
    seconds_past = last_vote_timestamp - first_vote_timestamp
    # horas decorridas desde o primeiro voto
    hours_past = seconds_past / 3600.0

    # como estamos calculando votos/hora
    # se for menos de uma hora passada entre todos
    # os votos então hora = 1
    if hours_past < 1
      hours_past = 1
    end

    # calculo de votos por hora
    votes_per_hour = total_votes / hours_past

    {
      total_votes: total_votes,
      votes_per_hour: votes_per_hour.round(0),
      participants: participants.select_id_name_and_total_votes,
    }
  end
end