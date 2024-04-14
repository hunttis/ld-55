extends Node2D

func _ready():
	for particles in get_children():
		particles.emitting = true

func _process(_delta):
	for particles in get_children():
		if !particles.emitting:
			self.queue_free()
