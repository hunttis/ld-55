class_name Friendly
extends Area2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var damage: int = 1
@export var health: int = 1

@export var direction = 1
var allow_move = false

func _ready():
	Signals.battle_process.connect(_on_battle_process)
	sprite.play('idle')

func _physics_process(_delta):
	if allow_move:
		position.x += direction * SPEED * _delta

		#Out of bounds. Remove from tree
		if position.x > 1280:
			queue_free()

func _on_battle_process():
	allow_move = true

func _on_area_entered(area:Area2D):
	if area is Enemy:
		Signals.enemy_destroyed.emit()
		area.queue_free()
		queue_free()
