extends Node2D

var destroy_timer = 3
var queued_destroy = false
var element = null

func _ready():
	for particles in get_children():
		particles.emitting = true

func _process(_delta):
	if element:
		match element:
			Global.VFX.APPLE_JUICE:
				modulate = Color.YELLOW
			Global.VFX.ONION_JUICE:
				modulate = Color.WHITE
			Global.VFX.PEAR_JUICE:
				modulate = Color.GREEN
			Global.VFX.ORANGE_JUICE:
				modulate = Color.ORANGE

	destroy_timer -= _delta
	
	if queued_destroy:
		if destroy_timer <= 0:
			self.queue_free()

	if destroy_timer <= 1:
		for particles in get_children():
			particles.emitting = false

	for particles: CPUParticles2D in get_children():
		if !particles.emitting && !queued_destroy:
			queued_destroy = true
			destroy_timer = particles.lifetime * 2



