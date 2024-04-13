extends Node2D


@export_range(0,100) var target: float
@export var perfect_margin: float
@export var good_margin: float
@export var medicore_margin: float
@export var max_mana: float = 2.0
@export var meter_type: Global.ELEMENT

@onready var meter: TextureProgressBar = $ProgressBar
@onready var sweetspot: Sprite2D = $SweetSpot

const METER_WIDTH = 300


func _ready():
	meter.max_value = max_mana
	meter.value = 0
	meter.step = 0.01
	Signals.button_released.connect(_on_button_released)
	sweetspot.position.x = METER_WIDTH * (target/100);


func _on_button_released(button_type):
	if button_type == meter_type:
		var difference = abs(target - Global.mana[meter_type])
		if difference < perfect_margin:
			print("PERFECT HIT")
		elif difference < good_margin:
			print("GOOD HIT")
		elif difference < medicore_margin:
			print("MEDIOCRE HIT")
		else:
			print("MISS")
		Global.mana[meter_type] = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	meter.value = Global.mana[meter_type]
	
