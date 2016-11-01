# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

team_list = [["Dallas","Cowboys","DAL"],["New York","Giants","NYG"],["Philadelphia","Eagles","PHI"],
["Washington","Redskins","WAS"],["Chicago","Bears","CHI"],["Detroit","Lions","DET"],
["Green Bay","Packers","GB"],["Minnesota","Vikings","MIN"],["Atlanta","Falcons","ATL"],
["Carolina","Panthers","CAR"],["New Orleans","Saints","NO"],["Tampa Bay","Buccaneers","TB"],
["Arizona","Cardinals","ARZ"],["Los Angeles","Rams","LA"],["San Francisco","49ers","SF"],
["Seattle","Seahawks","SEA"],["Buffalo","Bills","BUF"],["Miami","Dolphins","MIA"],
["New England","Patriots","NE"],["New York","Jets","NYJ"],["Baltimore","Ravens","BAL"],
["Cincinnati","Bengals","CIN"],["Cleveland","Browns","CLE"],["Pittsburgh","Steelers","PIT"],
["Houston","Texans","HOU"],["Indianapolis","Colts","IND"],["Jacksonville","Jaguars","JAX"],
["Tennessee","Titans","TEN"],["Denver","Broncos","DEN"],["Kansas City","Chiefs","KC"],
["Oakland","Raiders","OAK"],["San Diego","Chargers","SD"]]

id = 1
team_list.each do |location, name, abbreviation|
  Team.create(id: id, location: location, name: name, abbreviation: abbreviation)
  id += 1
end
