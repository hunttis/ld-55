extends Node2D


@export var target: float = 50
@export var speed: float = 4
@export var speed_multiplier: float = 1.10
@export var perfect_margin: float = 2
@export var good_margin: float = 2
@export var mediocre_margin: float = 2
@export var meter_type: Global.ELEMENT

@onready var meter: TextureProgressBar = $ProgressBar
@onready var sweetspot: Node2D = $HitAreaIndicator
@onready var debug_label = $DebugLabel

const METER_WIDTH = 300
const METER_HEIGHT = 24

const TEXTURE_PROGRESS_APPLE = preload("res://Assets/Images/straw-progress-apple.png")
const TEXTURE_PROGRESS_ONION = preload("res://Assets/Images/straw-progress-onion.png")
const TEXTURE_PROGRESS_ORANGE = preload("res://Assets/Images/straw-progress-orange.png")
const TEXTURE_PROGRESS_PEAR = preload("res://Assets/Images/straw-progress-pear.png")

var enabled = false

var perfect_margin_px: float
var good_margin_px: float
var mediocre_margin_px: float
var can_be_used: bool = true
var result = Global.STRAW_SCORE.MISS



func _ready():
	Signals.speed_up.connect(_on_speed_up);

	match meter_type:
		Global.ELEMENT.APPLE:
			meter.texture_progress = TEXTURE_PROGRESS_APPLE
		Global.ELEMENT.ONION:
			meter.texture_progress = TEXTURE_PROGRESS_ONION
		Global.ELEMENT.ORANGE:
			meter.texture_progress = TEXTURE_PROGRESS_ORANGE
		Global.ELEMENT.PEAR:
			meter.texture_progress = TEXTURE_PROGRESS_PEAR

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
		var cheer_position = sweetspot.global_position
		if difference < perfect_margin:
			result = Global.STRAW_SCORE.PERFECT
			Signals.add_score.emit(100000)
			Signals.create_vfx.emit(Global.VFX.CHEER_PERFECT, cheer_position)
			Sounds.play_sound.emit(Sounds.EFFECT.PERFECT)
			print("PERFECT HIT")
		elif difference < perfect_margin+good_margin:
			result = Global.STRAW_SCORE.GOOD
			Signals.add_score.emit(50000)
			Sounds.play_sound.emit(Sounds.EFFECT.GOOD)
			Signals.create_vfx.emit(Global.VFX.CHEER_GOOD, cheer_position)
			print("GOOD HIT")
		elif difference < perfect_margin+good_margin+mediocre_margin:
			result = Global.STRAW_SCORE.MEDIOCRE
			Signals.add_score.emit(10000)
			Sounds.play_sound.emit(Sounds.EFFECT.MEDIOCRE)
			Signals.create_vfx.emit(Global.VFX.CHEER_BAD, cheer_position)
			print("MEDIOCRE HIT")
		else:
			Sounds.play_sound.emit(Sounds.EFFECT.MISS)
			Signals.create_vfx.emit(Global.VFX.CHEER_MISS, cheer_position)
			print("MISS")
			result = Global.STRAW_SCORE.MISS
		
		match button_type:
			Global.ELEMENT.APPLE:
				var apple_tip = get_tree().get_nodes_in_group("apple_tip")[0]
				Signals.create_vfx.emit(Global.VFX.APPLE_JUICE, apple_tip.global_position)
				print("Apple ", apple_tip)
			Global.ELEMENT.ONION:
				var onion_tip = get_tree().get_nodes_in_group("onion_tip")[0]
				Signals.create_vfx.emit(Global.VFX.ONION_JUICE, onion_tip.global_position)
				print("Onion")
			Global.ELEMENT.PEAR:
				var pear_tip = get_tree().get_nodes_in_group("pear_tip")[0]
				Signals.create_vfx.emit(Global.VFX.PEAR_JUICE, pear_tip.global_position)
				print("Pear")
			Global.ELEMENT.ORANGE:
				var orange_tip = get_tree().get_nodes_in_group("orange_tip")[0]
				Signals.create_vfx.emit(Global.VFX.ORANGE_JUICE, orange_tip.global_position)
				print("Orange")
			
		
		Global.hits.append(result)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !enabled:
		return
	debug_label.text = str(can_be_used)
	if can_be_used:
		meter.value = Global.mana[meter_type]*10*speed
	
func reset_meter():
	result = Global.STRAW_SCORE.MISS
	enabled = Global.enabled_buttons.has(meter_type)

	can_be_used = true
	meter.value = 0
	target = randf_range(30,70)
#	perfect_margin = randf_range(1,3)
#	good_margin = randf_range(2,10)
#	mediocre_margin  = randf_range(10,50-target/2-perfect_margin-good_margin)
	perfect_margin_px = METER_WIDTH * (perfect_margin/100)
	good_margin_px = METER_WIDTH * (good_margin/100) + perfect_margin_px
	mediocre_margin_px = METER_WIDTH * (mediocre_margin/100) + good_margin_px
	sweetspot.position.x = METER_WIDTH * (target/100);
	sweetspot.position.y = 12
	sweetspot.set_margin_indicators(perfect_margin_px, good_margin_px, mediocre_margin_px)
	sweetspot.visible = enabled

func _on_speed_up():
	speed *= speed_multiplier
	Global.point_multiplier *= speed_multiplier
