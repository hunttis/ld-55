extends Node2D

var destroy_timer = 5
var queued_destroy = false

func _ready():
	for particles in get_children():
		particles.emitting = true

func _process(_delta):
	destroy_timer -= _delta
	
	if queued_destroy:
		if destroy_timer <= 0:
			self.queue_free()

	for particles: CPUParticles2D in get_children():
		if !particles.emitting && !queued_destroy:
			queued_destroy = true
			destroy_timer = particles.lifetime * 2

	# if Input.is_action_just_pressed("ui_accept"):
	# 	for particles: CPUParticles2D in get_children():
	# 		particles.emitting = false


