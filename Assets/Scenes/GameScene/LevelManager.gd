extends Node

const MAX_MOB_SIZE = 5

var mob_size = 0
var life_points = 10
var score = 0
var hi_score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.arrived_to_battlefield.connect(_on_summoning_complete)
	Signals.get_hurt.connect(_get_hurt)
	Signals.add_score.connect(_add_score)

func _get_hurt():
	life_points -= 1
	if life_points <= 0:
		life_points = 10
		Signals.game_over.emit()

func _add_score(amount):
	score += amount

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_summoning_complete(_summoned):
	mob_size +=1
	print("ADDING MOB SIZE")
	if mob_size>=MAX_MOB_SIZE:
		print("send mob")
		mob_size=0
		Signals.battle_start.emit()