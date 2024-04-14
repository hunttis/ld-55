extends Node2D

@onready var animation: AnimatedSprite2D = $SummonAnimation

var summoned_unit = 1

var unit_animations = {
	Global.SUMMON.FRIENDLY1: 'blueberry',
	Global.SUMMON.FRIENDLY2: 'blackberry',
	Global.SUMMON.FRIENDLY3: 'gooseberry',
	Global.SUMMON.FRIENDLY4: 'cherry',
	Global.SUMMON.FRIENDLY5: 'strawberry',
}

func _ready():
	Signals.summoning_complete.connect(_on_summoning_complete)
	animation.hide()
	
func _on_summoning_complete(summoned):
	Signals.create_vfx.emit(Global.VFX.SMOKE, Vector2(1280.0/2, 720.0/2 + 32))
	print("hits ",Global.hits)
	if(sum_array(Global.hits) == 0):
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_FAIL)
		# Signal for fup animation
		# disable inputs for the animation duration
		Signals.total_fup.emit()
	else:
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_START)
		animation.show()
		summoned_unit = summoned
		Signals.disable_all_straws.emit()
		animation.play(unit_animations[summoned_unit])

func _on_animation_finished():
	Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_END)
	Signals.send_to_battlefield.emit(summoned_unit)
	animation.hide()
	
func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum
