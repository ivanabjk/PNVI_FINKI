extends Node

const MINUTES_PER_DAY: int = 24 * 60
const MINUTES_PER_HOUR: int = 60
const GAME_MINUTE_DURATION: float = TAU / MINUTES_PER_DAY

var game_spreed: float = 5.0

var initial_day: int = 1
var initial_hour: int = 12
var initial_minute: int = 30

var time: float = 0.0
var current_minute: int = -1
var current_days: int = 0

signal 
