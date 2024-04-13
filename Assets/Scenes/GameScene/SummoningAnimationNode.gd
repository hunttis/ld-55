extends Node2D

@onready var animation: AnimatedSprite2D = $SummonAnimation

const MAX_MOB_SIZE = 5
var mob_size = 0
var summoned_unit = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.summoning_complete.connect(_on_summoning_complete)
	animation.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_summoning_complete(summoned):
	animation.show()
	summoned_unit = summoned

	#Signals.disable_input.emit()
	animation.play("default")

func _on_animation_finished():
	mob_size +=1
	Signals.reset_all_taps.emit()
	Signals.summon.emit(summoned_unit)
	animation.hide()
	if mob_size>=MAX_MOB_SIZE:
		print("send mob")
		mob_size=0
		Signals.battle_start.emit()
