require "test_helper"

class ParticipantTest < ActiveSupport::TestCase
  def setup
    super
  end

  test "it should order results by name A-Z" do
    participants = Participant.all.order_by_name
    first_participant = participants.first

    # como definido nas fixtures
    assert_equal "Andressa Urach", first_participant.name
  end

  test "it should order participants by highest votes" do

    # fazendo 1 voto a mais para o participante 1
    # além do 1 já definido na fixture
    participant = Participant.last
    UpvoteJob.perform_now(participant)

    participants = Participant.all.order_by_higher_total_votes
    first_participant = participants.first

    assert_equal "Theo Becker", first_participant.name
  end

end
