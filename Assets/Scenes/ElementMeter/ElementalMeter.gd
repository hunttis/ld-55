extends Node2D


@export var target: float = 50
@export var speed: float = 3
@export var perfect_margin: float = 5
@export var good_margin: float = 10
@export var mediocre_margin: float = 10
@export var meter_type: Global.ELEMENT

@onready var meter: TextureProgressBar = $ProgressBar
@onready var sweetspot: Node2D = $HitAreaIndicator
@onready var debug_label = $DebugLabel

const METER_WIDTH = 300

var enabled = false

var perfect_margin_px: float
var good_margin_px: float
var mediocre_margin_px: float
var can_be_used: bool = true
var result = MISS

enum {
	PERFECT,
	GOOD,
	MEDIOCRE,
	MISS
}

func _ready():
	enabled = Global.enabled_buttons.has(meter_type)
	meter.max_value = 100
	meter.value = 0
	meter.step = 0.01
	Signals.button_released.connect(_on_button_released)
	var sb = StyleBoxFlat.new()
	meter.add_theme_stylebox_override("fill", sb)
	sb.bg_color = Color("ff0000")


func _on_button_released(button_type):
	if button_type == meter_type:
		var difference = abs(target - meter.value)
		can_be_used = false
		if difference < perfect_margin:
			result = PERFECT
			print("PERFECT HIT")
		elif difference < perfect_margin+good_margin:
			result = GOOD
			print("GOOD HIT")
		elif difference < perfect_margin+good_margin+mediocre_margin:
			result = MEDIOCRE
			print("MEDIOCRE HIT")
		else:
			print("MISS")
			result = MISS
		Global.hits.append(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !enabled:
		return
	debug_label.text = str(can_be_used)
	if can_be_used:
		meter.value = Global.mana[meter_type]*10*speed
	
func reset_meter():
	result = MISS
	enabled = Global.enabled_buttons.has(meter_type)

	can_be_used = true
	meter.value = 0
	target = randf_range(30,70)
	perfect_margin = randf_range(1,3)
	good_margin = randf_range(2,10)
	mediocre_margin  = randf_range(10,50-target/2-perfect_margin-good_margin)
	perfect_margin_px = METER_WIDTH * (perfect_margin/100)
	good_margin_px = METER_WIDTH * (good_margin/100) + perfect_margin_px
	mediocre_margin_px = METER_WIDTH * (mediocre_margin/100) + good_margin_px
	sweetspot.position.x = METER_WIDTH * (target/100);
	sweetspot.set_margin_indicators(perfect_margin_px, good_margin_px, mediocre_margin_px)
	sweetspot.visible = enabled
