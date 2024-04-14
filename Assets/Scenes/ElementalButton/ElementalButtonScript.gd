extends Node2D

@onready var sprite: AnimatedSprite2D= $ASprite
@onready var juice_box: AnimatedSprite2D= $JuiceBox
@onready var debug_label = $DebugLabel
@export var button_type: Global.ELEMENT 

var enabled = false
var is_pressed = false
var released = false

func _ready():
	Signals.debug_toggled.connect(_on_debug_toggled)
	enabled = Global.enabled_buttons.has(button_type)
	juice_box.set_frame_and_progress(button_type, 0)
	_on_debug_toggled()
	Signals.release_buttons.connect(_on_button_released)

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
		button_release()

	if is_pressed:
		Global.mana[button_type] += delta
		
func reset_button():
	released = false
	enabled = Global.enabled_buttons.has(button_type)
	sprite.play("default")

func _on_debug_toggled():
	debug_label.visible = !debug_label.visible
	sprite.visible = Global.DEBUG;

func button_release():
		is_pressed = false
		released = true
		sprite.play("default")
		Signals.button_released.emit(button_type)
		Signals.button_released_manager.emit()

func _on_button_released():
	if enabled:
		button_release()