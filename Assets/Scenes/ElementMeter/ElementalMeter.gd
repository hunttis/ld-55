extends Node2D


@export var target: float = 25
@export var speed: float = 1
@export var perfect_margin: float = 10
@export var good_margin: float = 20
@export var mediocre_margin: float = 40
@export var meter_type: Global.ELEMENT

@onready var meter: TextureProgressBar = $ProgressBar
@onready var sweetspot: Sprite2D = $SweetSpot

const METER_WIDTH = 300

func _ready():
	meter.max_value = 100
	meter.value = 0
	meter.step = 0.01
	Signals.button_released.connect(_on_button_released)
	sweetspot.position.x = METER_WIDTH * (target/100);


func _on_button_released(button_type):
	if button_type == meter_type:
		var difference = abs(target - meter.value)
		print(difference, " ", perfect_margin)
		if difference < perfect_margin:
			print("PERFECT HIT")
		elif difference < good_margin:
			print("GOOD HIT")
		elif difference < mediocre_margin:
			print("MEDIOCRE HIT")
		else:
			print("MISS")
		Global.mana[meter_type] = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	meter.value = Global.mana[meter_type]*10*speed
	
