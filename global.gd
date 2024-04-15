extends Node

const NAME_OF_THE_GAME = "FRUIT PUNCH"
const MAX_MOB_SIZE = 3

var hi_score = 1700000
var score = 0
var DEBUG = false
var show_tutorial = true
var quit_game_action = "quit_game_action"
var all_buttons = [ELEMENT.PEAR, ELEMENT.APPLE, ELEMENT.ONION, ELEMENT.ORANGE]
var enabled_buttons: Array
var enabled_buttons_count = STRAWS.ONE
var point_multiplier = 1.0
var total_wave_count = 0

enum ELEMENT {
	PEAR,
	APPLE,
	ONION,
	ORANGE
}

enum SUMMON {
	FRIENDLY1,
	FRIENDLY2,
	FRIENDLY3,
	FRIENDLY4,
	FRIENDLY5,
}


enum VFX {
	CHEER_PERFECT,
	CHEER_GOOD,
	CHEER_BAD,
	CHEER_MISS,
	SMOKE,
	CRASH,
	MUTE,
	SOUNDS_ON,
	SUMMON,
	APPLE_JUICE,
	ONION_JUICE,
	PEAR_JUICE,
	ORANGE_JUICE,
	BATTLE_DAMAGE,
	HIGHLIGHT
}

enum STRAWS {
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4
}
var hits = []
enum STRAW_SCORE{
	MISS,
	MEDIOCRE,
	GOOD,
	PERFECT,
}
var mana = {
	ELEMENT.PEAR: 0,
	ELEMENT.APPLE: 0,
	ELEMENT.ONION: 0,
	ELEMENT.ORANGE: 0
}

var ElementActions = {
	ELEMENT.PEAR: "air_action",
	ELEMENT.APPLE: "earth_action",
	ELEMENT.ONION: "fire_action",
	ELEMENT.ORANGE: "water_action"
}
func select_random_straws():
	if enabled_buttons_count == 0:
		enabled_buttons = []
	else: 
		all_buttons.shuffle();
		enabled_buttons = all_buttons.slice(0, enabled_buttons_count)

func _ready():
	Signals.reset_all_taps.connect(_on_reset_summoner_pressed)
	Signals.disable_all_straws.connect(_on_disable_all_straws)
	Signals.pick_new_straws.connect(_on_pick_new_straws)
	select_random_straws()

func _process(_delta):
	if Input.is_action_just_pressed("debug_toggle") && false:
		DEBUG = !DEBUG
		Signals.debug_toggled.emit()

func _on_reset_summoner_pressed():
	mana = {
		ELEMENT.PEAR: 0,
		ELEMENT.APPLE: 0,
		ELEMENT.ONION: 0,
		ELEMENT.ORANGE: 0
	}
	hits = []
	
func _on_disable_all_straws():
	_set_straw_count(0)

func _on_pick_new_straws():
	_set_straw_count(Difficulty.current_difficulty)
	_highlight_enabled_buttons()
	
func _highlight_enabled_buttons():
	if enabled_buttons.has(ELEMENT.APPLE):
		print("highlighting apple")
		var apple_hint = get_tree().get_first_node_in_group("pear_hint")
		Signals.create_vfx.emit(Global.VFX.HIGHLIGHT, apple_hint.global_position)
		
	if enabled_buttons.has(ELEMENT.ONION):
		print("highlighting onion")
		var onion_hint = get_tree().get_first_node_in_group("onion_hint")
		Signals.create_vfx.emit(Global.VFX.HIGHLIGHT, onion_hint.global_position)
		
	if enabled_buttons.has(ELEMENT.PEAR):
		print("highlighting pear")
		var pear_hint = get_tree().get_first_node_in_group("apple_hint")
		Signals.create_vfx.emit(Global.VFX.HIGHLIGHT, pear_hint.global_position)
		
	if enabled_buttons.has(ELEMENT.ORANGE):
		print("highlighting orange")
		var orange_hint = get_tree().get_first_node_in_group("orange_hint")
		Signals.create_vfx.emit(Global.VFX.HIGHLIGHT, orange_hint.global_position)

func _set_straw_count(count):
	enabled_buttons_count = count
	select_random_straws()
	Signals.reset_all_taps.emit()
	
func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum
