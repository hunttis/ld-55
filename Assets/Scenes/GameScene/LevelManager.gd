extends Node

var mob_size = 0
var life_points = 10

var wave_count = 0
# 1 first difficulty wave, 2 second difficulty waves, 3 third difficulty waves
var progression = [1,2,2]

@onready var level_timer: Timer = $LevelTimer
@onready var timer_label: Label = $TimerLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.arrived_to_battlefield.connect(_on_arrived_to_battlefield)
	Signals.total_fup.connect(_on_arrived_to_battlefield)
	Signals.get_hurt.connect(_get_hurt)
	Signals.add_score.connect(_add_score)
	Signals.battle_resolved.connect(_on_battle_resolved)
	Signals.start_game.connect(_on_start_game)
	Signals.summoning_complete.connect(_on_summoning_complete)

func _process(_delta):
	if not level_timer.is_stopped():
		timer_label.text = "%d" % ceil(level_timer.time_left)

func _on_start_game():
	Global.score = 0
	Global.total_wave_count = 0
	Signals.scores_changed.emit()
	Signals.battle_init.emit(3)
	Signals.pick_new_straws.emit()
	level_timer.start()
	timer_label.visible = true

func _get_hurt():
	life_points -= 1
	if life_points <= 0:
		life_points = 10
		if Global.score > Global.hi_score:
			Global.hi_score = Global.score
			Signals.scores_changed.emit()
		Signals.game_over.emit()

func _add_score(amount):
	Global.score += amount
	Signals.scores_changed.emit()

func _on_arrived_to_battlefield():
	mob_size +=1
	if mob_size >= Global.MAX_MOB_SIZE:
		mob_size=0
		wave_count +=1
		print("send mob ",wave_count)
		Signals.battle_start.emit()
	else:
		Signals.pick_new_straws.emit()
		timer_label.visible = true
		level_timer.start()
		
func _on_battle_resolved():
	if Global.total_wave_count > Difficulty.speed_up_start_round:
		Signals.speed_up.emit()

	if Difficulty.current_difficulty != Difficulty.MAX_DIFFICULTY && wave_count >= progression[Difficulty.current_difficulty-1]:
		wave_count = 0
		Difficulty.current_difficulty = min(Difficulty.current_difficulty+1,Difficulty.MAX_DIFFICULTY)
	
	Signals.battle_init.emit(Global.MAX_MOB_SIZE)
	Signals.pick_new_straws.emit()
	timer_label.visible = true
	level_timer.start()

func _on_level_timer_timeout():
	Signals.release_buttons.emit()

func _on_summoning_complete(_summon):
	level_timer.stop()
	timer_label.visible = false
