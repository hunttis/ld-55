extends Node


var hi_score = 0
var score = 0

const NAME_OF_THE_GAME = "The Name of The Game"

enum ELEMENT {
	AIR,
	EARTH,
	FIRE,
	WATER
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
	SOUNDS_ON
}

enum STRAWS {
	ONE = 1,
	TWO = 2,
	THREE = 3,
	FOUR = 4
}
var hits = []

var mana = {
	ELEMENT.AIR: 0,
	ELEMENT.EARTH: 0,
	ELEMENT.FIRE: 0,
	ELEMENT.WATER: 0
}

var ElementActions = {
	ELEMENT.AIR: "air_action",
	ELEMENT.EARTH: "earth_action",
	ELEMENT.FIRE: "fire_action",
	ELEMENT.WATER: "water_action"
}

var quit_game_action = "quit_game_action"

const MAX_DIFFICULTY = 4
var current_difficulty = 4
var all_buttons = [ELEMENT.AIR, ELEMENT.EARTH, ELEMENT.FIRE, ELEMENT.WATER]

var enabled_buttons;
var enabled_buttons_count = STRAWS.THREE

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

func _on_reset_summoner_pressed():
	mana = {
		ELEMENT.AIR: 0,
		ELEMENT.EARTH: 0,
		ELEMENT.FIRE: 0,
		ELEMENT.WATER: 0
	}
	hits = []
	
func _on_disable_all_straws():
	_set_straw_count(0)

func _on_pick_new_straws():
	_set_straw_count(randi_range(1, current_difficulty))

func _set_straw_count(count):
	enabled_buttons_count = count
	select_random_straws()
	Signals.reset_all_taps.emit()
