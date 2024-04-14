extends Node

const NAME_OF_THE_GAME = "FRUIT PUNCH"
const MAX_DIFFICULTY = 4

var hi_score = 0
var score = 0
var DEBUG = false
var show_tutorial = true
var quit_game_action = "quit_game_action"
var current_difficulty = 1
var all_buttons = [ELEMENT.PEAR, ELEMENT.APPLE, ELEMENT.ONION, ELEMENT.ORANGE]
var enabled_buttons;
var enabled_buttons_count = STRAWS.ONE
var point_multiplier = 1.0
var wave_count = 0

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
	ORANGE_JUICE
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
	if Input.is_action_just_released("enable_straws_0"):
		_set_straw_count(0)
	if Input.is_action_just_released("enable_straws_1"):
		_set_straw_count(STRAWS.ONE)
	if Input.is_action_just_released("enable_straws_2"):
		_set_straw_count(STRAWS.TWO)
	if Input.is_action_just_released("enable_straws_3"):
		_set_straw_count(STRAWS.THREE)
	if Input.is_action_just_released("enable_straws_4"):
		_set_straw_count(STRAWS.FOUR)
	if Input.is_action_just_pressed("debug_toggle"):
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
	_set_straw_count(current_difficulty)

func _set_straw_count(count):
	enabled_buttons_count = count
	select_random_straws()
	Signals.reset_all_taps.emit()
	
func sum_array(array):
	var sum = 0.0
	for element in array:
		sum += element
	return sum
