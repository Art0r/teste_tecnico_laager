PARTICIPANTS_NAME = ["Theo Becker", "Andressa Urach"]

PARTICIPANTS_NAME.each do |name|
  participant = Participant.find_or_create_by!(name: name)
  Vote.create!(participant: participant)
end
