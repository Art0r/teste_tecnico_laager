require "test_helper"

class ParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participant = participants(:one)

    # in cada teste reseta o total de votos
    @participant.update!(total_votes: 0)
  end

  test "should update total_vote count on calling /participants/{id}/upvote" do
    patch upvote_participant_url(@participant.id)
    @participant.reload
    assert_equal 1, @participant.total_votes
  end

  test "should fail to update total_vote count on calling /participants/{id}/upvote on non-existing id" do
    patch upvote_participant_url(@participant.id + 10)
    @participant.reload
    assert_equal 0, @participant.total_votes
  end

end
