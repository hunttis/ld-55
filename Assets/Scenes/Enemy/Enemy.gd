class_name Enemy
extends Area2D


const SPEED = 300.0

@export var direction = -1
var allow_move = false

func _ready():
	Signals.battle_process.connect(_on_battle_process)

func _physics_process(_delta):
	if allow_move:
		position.x += direction * SPEED * _delta

func _on_battle_process():
	allow_move = true
