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

var summoned_creature
var summon_delay = 1
var summoning = false

func _ready():
	Signals.summoning_complete.connect(_on_summoning_complete)
	animation.hide()

func _process(delta):
	if summoning:
		summon_delay -= delta
		if summon_delay <= 0:
			summoning = false
			summon_delay = 1
			delayed_summoning()

func _on_summoning_complete(summoned):
	summoning = true
	summoned_creature = summoned
	print("Summoning animation should happen")
	Signals.create_vfx.emit(Global.VFX.SUMMON, Vector2(1280.0/2, 720.0/7*6))
	
func delayed_summoning():
	
	print("hits ",Global.hits)
	if(sum_array(Global.hits) == 0):
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_FAIL)
		# Signal for fup animation
		# disable inputs for the animation duration
		Signals.total_fup.emit()
	else:
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_START)
		animation.show()
		summoned_unit = summoned_creature
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
