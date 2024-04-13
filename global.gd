extends Node


const NAME_OF_THE_GAME = "The Name of The Game"

enum ELEMENT {
	AIR,
	EARTH,
	FIRE,
	WATER
}

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

var max_difficulty = 4
var enabled_buttons = 1;