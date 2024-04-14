extends Node2D

var animation_timer = 0.8
var animation_phase = 0

@onready var pillar_target = $PillarTarget
@onready var pillar_particles = $PillarTarget/PillarParticles
@onready var cloud_particles = $CloudParticles
@onready var smoke_particles = $SmokeParticles

func _ready():
	pillar_particles.emitting = true
	cloud_particles.emitting = true
	smoke_particles.emitting = false

func _process(delta):
	animation_timer -= delta

	if animation_phase == 0:
		pillar_target.position.y -= 300 * delta
		if animation_timer <= 0:
			pillar_particles.emitting = false
			print("Animation phase 0 done")
			smoke_particles.emitting = true
			animation_phase = 1
			animation_timer = 1
			Signals.summoning_animation_complete.emit()
			
	elif animation_phase == 1:
		if animation_timer <= 0:
			print("Animation phase 1 done")
			animation_phase = 2
	elif animation_phase == 2:
		queue_free()
