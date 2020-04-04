require 'nokogiri'
require 'httparty'
require 'byebug'
require 'csv'

class Player 
    attr_accessor :name, :college, :pos, :cmp, :att, :cmp_pct, :yds, :avg, :lng, :td, :int, :sack, :rtg

    def initialize(name, college, pos, cmp, att, cmp_pct, yds, avg, lng, td, int, sack, rtg)
        @name = name
        @college = college
        @pos = pos
        @cmp = cmp
        @att = att
        @cmp_pct = cmp_pct
        @yds = yds
        @avg = avg
        @lng = lng
        @td = td
        @int = int
        @sack = sack
        @rtg = rtg
    end
       
end

def espn_scraper()
    # URL that we want to target for our webscraper
    # Stats table - College football QB stats
    url = "https://www.espn.com/college-football/stats/player/_/view/offense/table/passing/sort/passingYards/dir/desc"

    # Makes 'get' request to the page at the URL and returns the raw html of that page
    response = HTTParty.get(url)
    # parsed the data into a format that we can use to get data from
    # we are parsing the response body, and not the response itself
    parsed_response = Nokogiri::HTML(response.body)

    players = []
    # Get list (an array) of players and what university they went to
    player_list = parsed_response.css('table.Table.Table--align-right.Table--fixed.Table--fixed-left tr.Table__TR.Table__TR--sm.Table__even .Table__TD div')
    # Gets the stats table rows in an array
    player_stats_table_in_rows = parsed_response.css('div.Table__Scroller tbody.Table__TBODY .Table__TR.Table__TR--sm.Table__even')

    for i in 0..player_list.length-1

        # get the name and college from the player_list array
        name = player_list[i].css('a').text
        college = player_list[i].css('span').text
        
        # creates array with all the fields from the current row
        player_stat_row_data_points = player_stats_table_in_rows[i].css('td')

        pos = player_stat_row_data_points[0].text
        cmp = player_stat_row_data_points[1].text
        att = player_stat_row_data_points[2].text
        cmp_pct = player_stat_row_data_points[3].text
        yds = player_stat_row_data_points[4].text
        avg = player_stat_row_data_points[5].text
        lng = player_stat_row_data_points[6].text
        td = player_stat_row_data_points[7].text
        int = player_stat_row_data_points[8].text
        sack = player_stat_row_data_points[9].text
        rtg = player_stat_row_data_points[10].text

        player = Player.new(name, college, pos, cmp, att, cmp_pct, yds, avg, lng, td, int, sack, rtg)

        players.push(player)
    end

    return players

end

# Only passing in a Player object here - Ruby not staticly typed so mentioning it here
def save_to_csv(players)
    CSV.open('collegeQBstats.csv', 'wb') do |csv|
        csv << ["NAME", "POS", "CMP", "ATT", "CMP%", "YDS", "AVG", "LNG", "TD", "INT", "SACK", "RTG"]
        for i in 0..players.length-1
            csv << [players[i].name, players[i].college, players[i].pos, players[i].cmp, players[i].att, players[i].cmp_pct, 
            players[i].yds, players[i].lng, players[i].td, players[i].int, players[i].sack, players[i].rtg]
        end
    end
end


player_stats = espn_scraper()
save_to_csv(player_stats)