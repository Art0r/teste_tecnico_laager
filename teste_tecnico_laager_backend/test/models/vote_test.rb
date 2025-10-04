require "test_helper"

class VoteTest < ActiveSupport::TestCase

  test "it should order votes by its creation date higher to lower" do
    participant = Participant.last
    UpvoteJob.perform_now(participant)

    votes = Vote.all.order_by_creation
    assert_equal participant, votes.first.participant
  end

end
