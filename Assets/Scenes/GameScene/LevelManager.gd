extends Node

const MAX_MOB_SIZE = 5
var mob_size = 0
var life_points = 10

var wave_count = 0
# 2 first difficulty waves, 2 second difficulty waves, 3 third difficulty waves
var progression = [1,2,3]

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.arrived_to_battlefield.connect(_on_arrived_to_battlefield)
	Signals.total_fup.connect(_on_arrived_to_battlefield)
	Signals.get_hurt.connect(_get_hurt)
	Signals.add_score.connect(_add_score)
	Signals.battle_resolved.connect(_on_battle_resolved)
	Signals.start_game.connect(_on_start_game)

func _on_start_game():
	Global.current_difficulty = 1
	Global.score = 0
	Signals.scores_changed.emit()
	Signals.battle_init.emit(5)
	Signals.pick_new_straws.emit()

func _get_hurt():
	life_points -= 1
	print("hurting "+str(life_points))
	if life_points <= 0:
		life_points = 10
		if Global.score > Global.hi_score:
			Global.hi_score = Global.score
			Signals.scores_changed.emit()
		Signals.game_over.emit()

func _add_score(amount):
	print("ADDED TO SCORE ", amount)
	Global.score += amount
	Signals.scores_changed.emit()

func _on_arrived_to_battlefield():
	mob_size +=1
	print("ADDING MOB SIZE ", mob_size)
	if mob_size>=MAX_MOB_SIZE:
		mob_size=0
		wave_count +=1
		print("send mob ",wave_count)
		Signals.battle_start.emit()
	else:
		Signals.pick_new_straws.emit()
		
func _on_battle_resolved():
	if Global.current_difficulty > 3:
		Signals.speed_up.emit()

	if wave_count >= progression[Global.current_difficulty-1]:
		wave_count = 0
		Global.current_difficulty = min(Global.current_difficulty+1,Global.MAX_DIFFICULTY)
	
	Signals.battle_init.emit(MAX_MOB_SIZE)
	Signals.pick_new_straws.emit()

	
