extends Node

var coins := 0
const NUM_COINS_TO_WIN = 10
var game_timer = 60
#var game_state = "start" # Can be: "start", "win", "lose"
var game_message = ""

signal timer_updated(time_left)
