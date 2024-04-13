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
	if(sum_array(Global.hits)/Global.hits.size()==3):
		Signals.total_fup.emit()
		Signals.reset_all_taps.emit()
	else:
		animation.show()
		summoned_unit = summoned
		#Signals.disable_input.emit()
		animation.play("default")

func _on_animation_finished():
	Signals.reset_all_taps.emit()
	Signals.send_to_battlefield.emit(summoned_unit)
	animation.hide()
	
static func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum
