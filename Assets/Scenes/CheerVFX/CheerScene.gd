extends Node2D

@onready var cheer = $CheerLabel

var cheer_type: Global.VFX
var active = false
var animation_time: float = 1.0

func _process(delta):

	if !active:
		match cheer_type:
			Global.VFX.CHEER_PERFECT:
				cheer.text = "P E R F E C T"
				cheer.modulate = Color.AQUAMARINE
			Global.VFX.CHEER_GOOD:
				cheer.text = "G O O D"
				cheer.modulate = Color.GREEN
			Global.VFX.CHEER_BAD:
				cheer.text = "B A D"
				cheer.modulate = Color.YELLOW
			Global.VFX.CHEER_MISS:
				cheer.text = "M I S S"
				cheer.modulate = Color.RED
		
		active = true
		cheer.text = "[center]" + cheer.text + "[/center]"

	if active:
		animation_time -= delta
		modulate.a = animation_time
		scale.x = animation_time
		scale.y = animation_time
		rotation_degrees += delta * 180

	if animation_time <= 0:
		queue_free()
