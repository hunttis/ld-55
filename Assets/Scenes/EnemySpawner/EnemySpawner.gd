extends Node

enum ENEMY_TYPE {
	TYPE1,
	TYPE2,
	TYPE3,
	TYPE4,
}

@export var delay: float

@onready var rally_point = $RallyPoint
@onready var timer = $Timer

var wave_size: int = 0
var enemy_count = 0

var enemy_scenes = {
	ENEMY_TYPE.TYPE1: preload("res://Assets/Scenes/Enemy/Enemy.tscn"),
	ENEMY_TYPE.TYPE2: preload("res://Assets/Scenes/Enemy/Enemy2.tscn"),
	ENEMY_TYPE.TYPE3: preload("res://Assets/Scenes/Enemy/Enemy3.tscn"),
	ENEMY_TYPE.TYPE4: preload("res://Assets/Scenes/Enemy/Enemy4.tscn")
}

func _ready():
	Signals.battle_init.connect(_on_wave_spawn)
	timer.wait_time = delay

func _on_timer_timeout():
	timer.wait_time = 1.0
	if enemy_count < wave_size:
		var enemy_scene = enemy_scenes[Difficulty.current_difficulty-1]
		var enemy_instance = enemy_scene.instantiate()	
		rally_point.add_child(enemy_instance)
		enemy_instance.position.x = enemy_instance.position.x + enemy_count * (16 + 32)
		enemy_count += 1
		Signals.enemy_spawned.emit()
	else:
		timer.stop()

func _on_wave_spawn(amount: int):
	wave_size = amount
	enemy_count = 0
	timer.wait_time = 2.0
	timer.start()
