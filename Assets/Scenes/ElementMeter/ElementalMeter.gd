extends Node2D


@export var target: float = 50
@export var speed: float = 1
@export var perfect_margin: float = 5
@export var good_margin: float = 10
@export var mediocre_margin: float = 10
@export var meter_type: Global.ELEMENT

@onready var meter: TextureProgressBar = $ProgressBar
@onready var sweetspot: Node2D = $HitAreaIndicator

const METER_WIDTH = 300

var perfect_margin_px: float
var good_margin_px: float
var mediocre_margin_px: float

func _ready():
	meter.max_value = 100
	meter.value = 0
	meter.step = 0.01
	perfect_margin_px = METER_WIDTH * (perfect_margin/100)
	good_margin_px = METER_WIDTH * (good_margin/100) + perfect_margin_px
	mediocre_margin_px = METER_WIDTH * (mediocre_margin/100) + good_margin_px
	Signals.button_released.connect(_on_button_released)

	sweetspot.position.x = METER_WIDTH * (target/100);
	sweetspot.set_margin_indicators(perfect_margin_px, good_margin_px, mediocre_margin_px)



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
	
