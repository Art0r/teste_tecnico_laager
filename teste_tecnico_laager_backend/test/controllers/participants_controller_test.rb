require "test_helper"

class ParticipantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @participant = participants(:one)
  end

  test "it should update votes on calling /participants/{id}/upvote" do

    # ativando o job
    assert_enqueued_jobs 1, only: UpvoteJob do
      patch upvote_participant_url(@participant.id)
    end

    # esperando o job se concretizar
    perform_enqueued_jobs

    # pois ja temos 2 votos definidos em fixture/votes o teste será para 3
    assert_equal 3, Vote.count
  end

end
