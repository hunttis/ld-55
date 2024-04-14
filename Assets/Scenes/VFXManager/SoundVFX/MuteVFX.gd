extends Node2D

var active = false
var animation_time: float = 1.5

var sounds_on = true

@onready var mute_sprite = $MuteSprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	z_index = 100
	if sounds_on:
		mute_sprite.play("soundson")
	else:
		mute_sprite.play("mute")
		mute_sprite.modulate = Color.ORANGE_RED
	animation_time -= delta
	modulate.a = animation_time
	scale.x = animation_time
	scale.y = animation_time

	if animation_time <= 0:
		queue_free()
	

