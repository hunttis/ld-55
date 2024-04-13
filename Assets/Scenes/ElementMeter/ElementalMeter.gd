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
var can_be_used: bool = true

func _ready():
	meter.max_value = 100
	meter.value = 0
	meter.step = 0.01
	Signals.button_released.connect(_on_button_released)
	Signals.reset_all_taps.connect(_on_reset_all_taps)
	var sb = StyleBoxFlat.new()
	meter.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ff0000")


func _on_button_released(button_type):
	if button_type == meter_type:
		var difference = abs(target - meter.value)
		can_be_used = false
		print(target, " ",difference, " ", perfect_margin)
		if difference < perfect_margin:
			print("PERFECT HIT")
		elif difference < perfect_margin+good_margin:
			print("GOOD HIT")
		elif difference < perfect_margin+good_margin+mediocre_margin:
			print("MEDIOCRE HIT")
		else:
			print("MISS")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if can_be_used:
		meter.value = Global.mana[meter_type]*10*speed
	
func _on_reset_all_taps():
	can_be_used = true
	meter.value = 0
	target = randf_range(30,70)
	perfect_margin = randf_range(1,3)
	good_margin = randf_range(2,10)
	mediocre_margin  = min(randf_range(10,100),50-target/2-perfect_margin-good_margin,10)
	print(meter_type, " ", target, " ",perfect_margin, " ", good_margin, " ", mediocre_margin)
	perfect_margin_px = METER_WIDTH * (perfect_margin/100)
	good_margin_px = METER_WIDTH * (good_margin/100) + perfect_margin_px
	mediocre_margin_px = METER_WIDTH * (mediocre_margin/100) + good_margin_px
	sweetspot.position.x = METER_WIDTH * (target/100);
	sweetspot.set_margin_indicators(perfect_margin_px, good_margin_px, mediocre_margin_px)

