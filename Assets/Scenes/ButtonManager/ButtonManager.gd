extends Node2D
@onready var air = $AirButton
@onready var earth = $EarthButton
@onready var fire = $FireButton
@onready var water = $WaterButton



# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.button_released_manager.connect(_on_button_released_manager)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_released_manager():
	var summoned = randi_range(0,4)
	print(Global.hits)
	var released_buttons = [air.released, earth.released, fire.released, water.released].count(true)
	if (released_buttons >= Global.enabled_buttons_count):
		print("all buttons released")
		Signals.summoning_complete.emit(summoned)
