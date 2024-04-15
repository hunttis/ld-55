extends Node

const MAX_DIFFICULTY = 4
var current_difficulty = 1
# 1 first difficulty wave, 2 second difficulty waves, 3 third difficulty waves
var progression = [1,2,2]
var speed_up_start_round = 5
var meter_speed: float = 4
var meter_speed_multiplier: float = 1.10
var summon_time: float = 6

enum DIFFICULTY {
	NONE,
    EASY,
	MEDIUM,
	PRETTY_HARD,
	UNFAIR,
}

var easy = {
	title = "Classic",
	current_difficulty = 1,
	progression = [1,2,2],
	speed_up_start_round = 5,
	meter_speed = 4,
	meter_speed_multiplier = 1.10,
    summon_time = 6
}

var medium = {
	title = "Medium",
	current_difficulty = 1,
	progression = [1,1,1],
	speed_up_start_round = 5,
	meter_speed = 8,
	meter_speed_multiplier = 1.08,
    summon_time = 5
}

var pretty_hard = {
	title = "Pretty Hard",
	current_difficulty = 4,
	progression = [],
	speed_up_start_round = 12,
	meter_speed = 12,
	meter_speed_multiplier = 1.05,
    summon_time = 2.5
}

var unfair = {
	title = "Actually Hard",
	current_difficulty = 4,
	progression = [],
	speed_up_start_round = 1,
	meter_speed = 4,
	meter_speed_multiplier = 1,
    summon_time = 3.5
}

var difficulties = {
    DIFFICULTY.EASY: easy,
	DIFFICULTY.MEDIUM: medium,
	DIFFICULTY.PRETTY_HARD: pretty_hard,
	DIFFICULTY.UNFAIR: unfair,
}

func _ready():
    Signals.set_difficulty.connect(_on_set_difficulty)

func _on_set_difficulty(difficulty: DIFFICULTY):
    current_difficulty = difficulties[difficulty].current_difficulty
    progression = difficulties[difficulty].progression
    speed_up_start_round = difficulties[difficulty].speed_up_start_round
    meter_speed = difficulties[difficulty].meter_speed
    meter_speed_multiplier = difficulties[difficulty].meter_speed_multiplier
    summon_time = difficulties[difficulty].summon_time
    print("Setting difficulty to: " +difficulties[difficulty].title)
    print(str(difficulties[difficulty]))
