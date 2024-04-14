extends Node2D

@onready var animation: AnimatedSprite2D = $SummonAnimation

var summoned_unit = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.summoning_complete.connect(_on_summoning_complete)
	animation.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_summoning_complete(summoned):
	print("hits ",Global.hits)
	if(sum_array(Global.hits) / Global.hits.size() == 3):
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_FAIL)
		# Signal for fup animation
		# disable inputs for the animation duration
		Signals.total_fup.emit()
	else:
		Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_START)
		animation.show()
		summoned_unit = summoned
		Signals.disable_all_straws.emit()
		animation.play("default")

func _on_animation_finished():
	Sounds.play_sound.emit(Sounds.EFFECT.SUMMON_END)
	Signals.send_to_battlefield.emit(summoned_unit)
	animation.hide()
	
func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum
