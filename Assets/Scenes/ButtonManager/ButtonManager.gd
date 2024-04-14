extends Node2D
@onready var pear =$Right/PearButton
@onready var apple = $Right/AppleButton
@onready var onion = $Left/OnionButton
@onready var orange = $Left/OrangeButton



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

	var released_buttons = [pear.released, apple.released, onion.released, orange.released].count(true)
	if (released_buttons >= Global.enabled_buttons_count):
		print("all buttons released")
		Signals.summoning_complete.emit(summoned)

func _on_reset_all_taps():
	pear.reset_button()
	apple.reset_button()
	onion.reset_button()
	orange.reset_button()
