require 'faker'

2.times { Team.create(name: Faker::Sports::Football.team) }

Team.all.each do |team|
  3.times { team.players.create(name: Faker::Sports::Football.player, number: Faker::Number.decimal_part(digits: 3)) }
end

3.times { Match.create(team_first: Team.first, team_second: Team.last) }

Indicator.create(name: 'Серия 3 пенальти')
Indicator.create(name: 'Удары по воротам 12+')

3.times do
  Achievement.create(match: Match.random, player: Player.random, indicator: Indicator.random)
end
