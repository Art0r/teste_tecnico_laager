require "test_helper"

class UpvoteJobTest < ActiveJob::TestCase
  def setup
    super
  end

  test "it should update votes count" do
    participant = Participant.first
    UpvoteJob.perform_now(participant)

    # pois ja temos 2 votos definidos em fixture/votes o teste será para 3
    assert_equal 3, Vote.count
  end

end
