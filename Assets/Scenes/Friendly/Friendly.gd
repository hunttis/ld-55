class_name Friendly
extends Area2D

const SPEED = 300.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var damage: int = 1
@export var health: int = 1

@export var direction = 1
var current_health: int = 0
var allow_move = false

func _ready():
	Signals.battle_process.connect(_on_battle_process)
	current_health = health
	sprite.play('idle')

func _physics_process(_delta):
	if allow_move:
		position.x += direction * SPEED * _delta

		#Out of bounds. Remove from tree
		if position.x > 1280:
			queue_free()

func _on_battle_process():
	allow_move = true
	if sprite.sprite_frames.has_animation('walk'):
		sprite.play('walk')

func _on_area_entered(area:Area2D):
	if area is Enemy:
		current_health -= area.do_damage()
		area.take_damage(damage)

		if current_health <= 0:
			queue_free()

func stop():
	allow_move = false
	sprite.play('idle')