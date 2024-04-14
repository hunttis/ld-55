class_name Enemy
extends Area2D


const SPEED = 300.0
@export var health: int = 1
@export var damage: int = 1
@export var direction = -1

var current_health = 0
var allow_move = false

func _ready():
	Signals.battle_process.connect(_on_battle_process)
	current_health = health

func _physics_process(_delta):
	if allow_move:
		position.x += direction * SPEED * _delta

func _on_battle_process():
	allow_move = true

func take_damage(damage_taken: int):
	current_health -= damage_taken
	if current_health <= 0:
		Signals.enemy_destroyed.emit()
		queue_free()

func do_damage() -> int:
	return damage