extends Node

@export_range(1,4) var start_difficulty = 1
@export var progression = [1,2,2]
@export var speed_up_start_round = 5
@export var meter_speed: float = 4
@export var meter_speed_multiplier: float = 1.10
@export var preset_difficulty: Difficulty.DIFFICULTY

func _ready():
	if preset_difficulty == Difficulty.DIFFICULTY.NONE:
		Difficulty.current_difficulty = start_difficulty
		Difficulty.progression = progression
		Difficulty.speed_up_start_round = speed_up_start_round
		Difficulty.meter_speed = meter_speed
		Difficulty.meter_speed_multiplier = meter_speed_multiplier
	else:
		Difficulty.current_difficulty = Difficulty.difficulties[preset_difficulty].current_difficulty
		Difficulty.progression = Difficulty.difficulties[preset_difficulty].progression
		Difficulty.speed_up_start_round = Difficulty.difficulties[preset_difficulty].speed_up_start_round
		Difficulty.meter_speed = Difficulty.difficulties[preset_difficulty].meter_speed
		Difficulty.meter_speed_multiplier = Difficulty.difficulties[preset_difficulty].meter_speed_multiplier

	print("Difficulty: ", Difficulty.current_difficulty)
	print("Progression: ", Difficulty.progression)
	print("Speed up start round: ", Difficulty.speed_up_start_round)
	print("Meter speed: ", Difficulty.meter_speed)
	print("Meter speed multiplier: ", Difficulty.meter_speed_multiplier)
