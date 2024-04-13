class_name Friendly
extends CharacterBody2D


const SPEED = 300.0

@export var direction = 1
var allow_move = false

func _ready():
	Signals.battle_start.connect(_on_battle_start)

func _physics_process(_delta):
	if allow_move:
		velocity.x = direction * SPEED

	move_and_slide()

func _on_battle_start():
	allow_move = true
