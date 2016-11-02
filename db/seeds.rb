# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

team_list = [["Dallas","Cowboys","DAL","NFC East"],["New York","Giants","NYG","NFC East"],["Philadelphia","Eagles","PHI","NFC East"],
["Washington","Redskins","WAS","NFC East"],["Chicago","Bears","CHI","NFC North"],["Detroit","Lions","DET","NFC North"],
["Green Bay","Packers","GB","NFC North"],["Minnesota","Vikings","MIN","NFC North"],["Atlanta","Falcons","ATL","NFC South"],
["Carolina","Panthers","CAR","NFC South"],["New Orleans","Saints","NO","NFC South"],["Tampa Bay","Buccaneers","TB","NFC South"],
["Arizona","Cardinals","ARZ","NFC West"],["Los Angeles","Rams","LA","NFC West"],["San Francisco","49ers","SF","NFC West"],
["Seattle","Seahawks","SEA","NFC West"],["Buffalo","Bills","BUF","AFC East"],["Miami","Dolphins","MIA","AFC East"],
["New England","Patriots","NE","AFC East"],["New York","Jets","NYJ","AFC East"],["Baltimore","Ravens","BAL","AFC North"],
["Cincinnati","Bengals","CIN","AFC North"],["Cleveland","Browns","CLE","AFC North"],["Pittsburgh","Steelers","PIT","AFC North"],
["Houston","Texans","HOU","AFC South"],["Indianapolis","Colts","IND","AFC South"],["Jacksonville","Jaguars","JAX","AFC South"],
["Tennessee","Titans","TEN","AFC South"],["Denver","Broncos","DEN","AFC West"],["Kansas City","Chiefs","KC","AFC West"],
["Oakland","Raiders","OAK","AFC West"],["San Diego","Chargers","SD","AFC West"]]

team_list.each do |location, name, abbreviation, division|
  Team.create(location: location, name: name, abbreviation: abbreviation, division: division)
end
