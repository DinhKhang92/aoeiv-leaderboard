const Map exampleLeaderboardData = {
  "total": 52511,
  "leaderboard_id": 17,
  "start": 1,
  "count": 2,
  "leaderboard": [exampleLeaderboardPlayerOne, exampleLeaderboardPlayerTwo]
};

const Map exampleLeaderboardPlayerOne = {
  "profile_id": 6925620,
  "rank": 1,
  "rating": 2000,
  "steam_id": "76561199217206774",
  "icon": null,
  "name": "[TK] GojirA",
  "clan": null,
  "country": null,
  "previous_rating": 1986,
  "highest_rating": 2000,
  "streak": 5,
  "lowest_streak": -2,
  "highest_streak": 11,
  "games": 179,
  "wins": 134,
  "losses": 45,
  "drops": 0,
  "last_match_time": 1640304542
};
const Map exampleLeaderboardPlayerTwo = {
  "profile_id": 5486218,
  "rank": 2,
  "rating": 1964,
  "steam_id": "76561198102726188",
  "icon": null,
  "name": "LucifroN7",
  "clan": null,
  "country": null,
  "previous_rating": 1956,
  "highest_rating": 1964,
  "streak": 14,
  "lowest_streak": -2,
  "highest_streak": 14,
  "games": 138,
  "wins": 114,
  "losses": 24,
  "drops": 0,
  "last_match_time": 1639581793
};

const List exampleRatingHistoryData = [
  {"rating": 1206, "num_wins": 65, "num_losses": 62, "streak": 2, "drops": 1, "timestamp": 1639534264},
  {"rating": 1191, "num_wins": 64, "num_losses": 62, "streak": 1, "drops": 1, "timestamp": 1639531895}
];

const List exampleMatchHistoryData = [
  exampleTwoVTwoMatch,
  exampleOneVOneMatch,
];

const Map exampleOneVOneMatch = {
  "match_id": "18006890",
  "lobby_id": "109775240932326823",
  "version": "9369",
  "name": "AUTOMATCH",
  "num_players": 2,
  "num_slots": 2,
  "map_size": 0,
  "map_type": 15,
  "ranked": false,
  "rating_type_id": 15,
  "server": "ukwest",
  "started": 1640542688,
  "players": [
    {
      "profile_id": 302408,
      "name": "GhostKZ",
      "clan": null,
      "country": null,
      "slot": 1,
      "slot_type": 1,
      "rating": 1237,
      "rating_change": null,
      "color": null,
      "team": 1,
      "civ": 6,
      "won": null
    },
    {
      "profile_id": 5150581,
      "name": "T0nb3rry",
      "clan": null,
      "country": null,
      "slot": 2,
      "slot_type": 1,
      "rating": 1241,
      "rating_change": null,
      "color": null,
      "team": 2,
      "civ": 6,
      "won": null
    }
  ]
};

const Map exampleTwoVTwoMatch = {
  "match_id": "18014733",
  "lobby_id": "109775240932484246",
  "version": "9369",
  "name": "AUTOMATCH",
  "num_players": 4,
  "num_slots": 4,
  "map_size": 2,
  "map_type": 7,
  "ranked": false,
  "rating_type_id": 16,
  "server": "ukwest",
  "started": 1640545301,
  "players": [
    {
      "profile_id": 5150581,
      "name": "T0nb3rry",
      "clan": null,
      "country": null,
      "slot": 1,
      "slot_type": 1,
      "rating": 1346,
      "rating_change": null,
      "color": null,
      "team": 1,
      "civ": 6,
      "won": null
    },
    {
      "profile_id": 738618,
      "name": "Kuaenn",
      "clan": null,
      "country": null,
      "slot": 2,
      "slot_type": 1,
      "rating": 1220,
      "rating_change": null,
      "color": null,
      "team": 1,
      "civ": 5,
      "won": null
    },
    {
      "profile_id": 473462,
      "name": "Maldhar",
      "clan": null,
      "country": null,
      "slot": 3,
      "slot_type": 1,
      "rating": 1344,
      "rating_change": null,
      "color": null,
      "team": 2,
      "civ": 5,
      "won": null
    },
    {
      "profile_id": 7446490,
      "name": "OutboundWheat99",
      "clan": null,
      "country": null,
      "slot": 4,
      "slot_type": 1,
      "rating": 1257,
      "rating_change": null,
      "color": null,
      "team": 2,
      "civ": 6,
      "won": null
    }
  ]
};
