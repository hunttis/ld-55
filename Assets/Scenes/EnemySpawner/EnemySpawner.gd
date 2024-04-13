extends Node

enum ENEMY_TYPE {
	TYPE1,
	TYPE2,
	TYPE3
}

@export var enemy_type: ENEMY_TYPE 
@export var wave_size: int
@export var delay: float

@onready var rally_point = $RallyPoint
@onready var timer = $Timer
var enemy_count = 0

var enemy_scenes = {
	ENEMY_TYPE.TYPE1: "res://Assets/Scenes/Enemy/Enemy.tscn"
}
var enemy_scene: PackedScene

func _ready():
	enemy_scene = load(enemy_scenes[enemy_type])
	timer.wait_time = delay
	timer.start()

func _on_timer_timeout():
	if enemy_count < wave_size:
		var enemy_instance = enemy_scene.instantiate()	
		rally_point.add_child(enemy_instance)
		enemy_instance.position.x = enemy_instance.position.x + enemy_count * (16 + 32)
		enemy_count += 1
	
	if enemy_count == wave_size:
		Signals.battle_start.emit()
