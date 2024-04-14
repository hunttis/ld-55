extends Node2D

@onready var sprite: AnimatedSprite2D= $ASprite
@onready var debug_label = $DebugLabel
@export var button_type: Global.ELEMENT 

var enabled = false
var is_pressed = false
var released = false

func _ready():
	enabled = Global.enabled_buttons.has(button_type)
	sprite.play("default")
	Signals.reset_all_taps.connect(_on_reset_all_taps)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !enabled:
		return

	debug_label.text = str(is_pressed)+" " + str(released)
	if Input.is_action_just_pressed(Global.ElementActions[button_type]):
		is_pressed = true
		sprite.play("pressed")
		Signals.button_pressed.emit(button_type)

	if Input.is_action_just_released(Global.ElementActions[button_type]):
		is_pressed = false
		released = true
		sprite.play("default")
		Signals.button_released.emit(button_type)
		Signals.button_released_manager.emit()

	if is_pressed:
		Global.mana[button_type] += delta
		
func _on_reset_all_taps():
	released = false
	enabled = Global.enabled_buttons.has(button_type)
	sprite.play("default")
