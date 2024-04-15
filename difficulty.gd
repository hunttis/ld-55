extends Node

const MAX_DIFFICULTY = 4
var current_difficulty = 1
# 1 first difficulty wave, 2 second difficulty waves, 3 third difficulty waves
var progression = [1,2,2]
var speed_up_start_round = 5
var meter_speed: float = 4
var meter_speed_multiplier: float = 1.10

enum DIFFICULTY {
    NONE,
    PROGRESSIVE,
    PRETTY_HARD,
    UNFAIR,
}

var progressive = {
    current_difficulty = 1,
    progression = [1,2,2],
    speed_up_start_round = 5,
    meter_speed = 4,
    meter_speed_multiplier = 1.10,
}

var pretty_hard = {
    current_difficulty = 4,
    progression = [],
    speed_up_start_round = 100,
    meter_speed = 6,
    meter_speed_multiplier = 1.02,
}

var unfair = {
    current_difficulty = 4,
    progression = [],
    speed_up_start_round = 1,
    meter_speed = 5.5,
    meter_speed_multiplier = 1.4,
}

var difficulties = {
    DIFFICULTY.PROGRESSIVE: progressive,
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