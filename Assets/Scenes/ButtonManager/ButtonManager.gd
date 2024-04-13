extends Node2D
@onready var air = $AirButton
@onready var earth = $EarthButton
@onready var fire = $FireButton
@onready var water = $WaterButton



# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.button_released.connect(_on_button_released)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_released():
	print( air.released, earth.released,fire.released, water.released)
	var summoned = randi_range(0,2)
	var released_buttons = [air.released, earth.released, fire.released, water.released].count(true)
	if (released_buttons >= Global.enabled_buttons):
		Signals.summoning_complete.emit(summoned)
