extends Node2D

@onready var sprite: AnimatedSprite2D= $ASprite

@export var button_type: Global.ELEMENT 

var is_pressed = false

func _ready():
	sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed(Global.ElementActions[button_type]):
		is_pressed = true
		sprite.play("pressed")
		Signals.button_pressed.emit(button_type)

	if Input.is_action_just_released(Global.ElementActions[button_type]):
		Signals.button_released.emit(button_type)
		is_pressed = false
		sprite.play("default")

	if is_pressed:
		Global.mana[button_type] += delta
