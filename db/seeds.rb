require 'faker'
require 'benchmark'

def create_teams(count: 5000)
  teams = []

  time = Benchmark.realtime do
    count.times { teams << { name: Faker::Sports::Football.team, created_at: Time.current, updated_at: Time.current } }

    Team.insert_all(teams)
  end

  puts "Created #{count} teams in #{time} seconds"
end

def create_players
  players = []

  time = Benchmark.realtime do
    Team.find_each do |team|
      rand(25..30).times { players << { team_id: team.id, name: Faker::Sports::Football.player,
                                        number: Faker::Number.decimal_part(digits: 3),
                                        created_at: Time.current, updated_at: Time.current } }
    end

    Player.insert_all(players)
  end

  puts "Created #{players.size} players in #{time} seconds"
end

def create_matches_and_participants(count: 1000)
  matches = []
  match_players = []

  time = Benchmark.realtime do
    count.times do |i|
      shuffled_teams = Team.all.sample(2)
      team_first = shuffled_teams.first
      team_second = shuffled_teams.last

      match = { id: i, team_first_id: team_first.id, team_second_id: team_second.id,
                created_at: Time.current, updated_at: Time.current }
      matches << match

      first_team_percent = rand(70..80)
      second_team_percent = rand(70..80)

      team_first.percentage_players(first_team_percent).find_each do |player|
        match_players << { team_id: player.team.id, player_id: player.id, match_id: match[:id],
                           created_at: Time.current, updated_at: Time.current }
      end

      team_second.percentage_players(second_team_percent).find_each do |player|
        match_players << { team_id: player.team.id, player_id: player.id, match_id: match[:id],
                           created_at: Time.current, updated_at: Time.current }
      end
    end

    Match.insert_all(matches)
    MatchPlayer.insert_all(match_players)
  end

  puts "Created #{matches.size} matches and #{match_players.size} participants of the match in #{time} seconds"
end

def create_indicators
  indicators = [
    "Построение конструктивных атак", "Владение мячом и контроль игры", "Блокирование угловых ударов",
    "Защита от атак", "Комбинированные пасы", "Выигрыш аэроборьбы в центре поля", "Поддержка игры средневахтов и нападающих",
    "Организация обороны на штрафной", "Сглаживание контратак", "Активная защита в штрафной", "Стандартные атаки",
    "Комбинации на стандартах", "Закрытие противника при владении мячом", "Грамотное отбитие мяча в защите",
    "Оперативная реализация контратак", "Сотрудничество и обмен пасами на средней половине поля", "Обводки и дриблинги в нападении",
    "Надежная оборона в своей штрафной", "Пресинг и антипресинг", "Организация игры на открытом поле"
  ]

  indicators.each { |i| Indicator.create(name: i) }
end

def create_achievements(count: 10_000)
  achievements = []
  match_ids = Match.pluck(:id)
  player_ids = MatchPlayer.limit(20000).pluck(:id)
  indicator_ids = Indicator.pluck(:id)

  time = Benchmark.realtime do
    count.times do
      shuffled_match = match_ids.shuffle.first
      shuffled_player = player_ids.shuffle.first
      shuffled_indicator = indicator_ids.shuffle.first
      achievements << { match_id: shuffled_match, player_id: shuffled_player, indicator_id: shuffled_indicator,
                        created_at: Time.current, updated_at: Time.current }
    end

    Achievement.insert_all(achievements)
  end

  puts "Created #{count} achievements in #{time} seconds"
end

create_teams
create_players
create_matches_and_participants
create_indicators
create_achievements
