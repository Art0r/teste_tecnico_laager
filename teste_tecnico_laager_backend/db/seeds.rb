(1..2).each { |_|
  Participant.find_or_create_by!(name: Faker::Name.name)
}
