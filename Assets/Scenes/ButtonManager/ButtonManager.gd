extends Node2D
@onready var air = $AirButton
@onready var earth = $EarthButton
@onready var fire = $FireButton
@onready var water = $WaterButton



# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.button_released_manager.connect(_on_button_released_manager)
	Signals.reset_all_taps.connect(_on_reset_all_taps)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_released_manager():
	var summoned = 0
	var summoned_score = Global.sum_array(Global.hits)
	if summoned_score >= 11:
		summoned = Global.SUMMON.FRIENDLY5
	elif summoned_score >= 8:
		summoned = Global.SUMMON.FRIENDLY4
	elif summoned_score >= 5:
		summoned = Global.SUMMON.FRIENDLY3
	elif summoned_score >= 2:
		summoned = Global.SUMMON.FRIENDLY2
	else:
		summoned = Global.SUMMON.FRIENDLY1

	var released_buttons = [air.released, earth.released, fire.released, water.released].count(true)
	if (released_buttons >= Global.enabled_buttons_count):
		print("all buttons released")
		Signals.summoning_complete.emit(summoned)

func _on_reset_all_taps():
	air.reset_button()
	earth.reset_button()
	fire.reset_button()
	water.reset_button()