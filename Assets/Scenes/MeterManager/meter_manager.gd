extends Node2D
@onready var fire = $OnionMeter
@onready var air = $PearMeter
@onready var earth = $AppleMeter
@onready var water = $OrangeMeter

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.reset_all_taps.connect(_on_reset_all_taps)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_reset_all_taps():
	fire.reset_meter()
	air.reset_meter()
	earth.reset_meter()
	water.reset_meter()
