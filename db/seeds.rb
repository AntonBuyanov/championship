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

def create_players(count: 25_000)
  players = []

  time = Benchmark.realtime do
    Team.find_each do |team|
      rand(25..30).times { players << { team_id: team.id, name: Faker::Sports::Football.player,
                                        number: Faker::Number.decimal_part(digits: 3),
                                        created_at: Time.current, updated_at: Time.current } }
    end

    Player.insert_all(players)
  end

  puts "Created #{count} players in #{time} seconds"
end

def create_matches(count: 50_000)
  matches = []
  team_ids = Team.pluck(:id)

  time = Benchmark.realtime do
    count.times do
      shuffled_teams = team_ids.shuffle.take(2)

      matches << { team_first_id: shuffled_teams.first, team_second_id: shuffled_teams.last,
                   created_at: Time.current, updated_at: Time.current }
    end

    Match.insert_all(matches)
  end

  puts "Created #{count} matches in #{time} seconds"
end

def create_match_players
  match_players = []

  time = Benchmark.realtime do
    Match.includes(team_first: :players, team_second: :players).find_each(batch_size: 2000) do |match|
      team_first = match.team_first
      team_second = match.team_second

      percent_players = rand(70..80)
      composition_first_team = team_first.percentage_players(percent_players)
      composition_second_team = team_second.percentage_players(percent_players)

      composition_first_team.find_each do |player|
        match_players << { match_id: match.id, player_id: player.id, team_id: team_first.id,
                           created_at: Time.current, updated_at: Time.current }
      end

      composition_second_team.find_each do |player|
        match_players << { match_id: match.id, player_id: player.id, team_id: team_second.id,
                           created_at: Time.current, updated_at: Time.current }
      end
    end

    MatchPlayer.insert_all(match_players)
  end

  puts "Created #{match_players.size} match players in #{time} seconds"
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
create_matches
create_match_players
create_indicators
create_achievements
