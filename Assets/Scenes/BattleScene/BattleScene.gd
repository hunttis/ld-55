extends Control

var wave_size: int = 0
var enemy_count: int = 0

# are we allowed to start battle if there are enough enemies
var start_battle: bool = false

# are we processing the battle
var processing_battle: bool = false

func _ready():
	Signals.battle_init.connect(_on_battle_reset)
	Signals.enemy_spawned.connect(_on_enemy_spawn)
	Signals.enemy_destroyed.connect(_on_enemy_destroyed)
	# Permission to do battle. We have done enough summoning attempts
	Signals.battle_start.connect(_on_battle_process)
	Signals.battle_resolved.connect(_on_resolve)

func _process(_delta):
	if enemy_count == wave_size && start_battle:
		Signals.battle_process.emit()
		processing_battle = true

	if enemy_count == 0 && processing_battle:
		processing_battle = false
		Signals.battle_end.emit()

func _on_home_area_entered(area:Area2D):
	if area is Enemy:
		Signals.create_vfx.emit(Global.VFX.CRASH, area.global_position)
		enemy_count -= 1
		area.queue_free()
		Sounds.play_sound.emit(Sounds.EFFECT.HURT)
		Signals.get_hurt.emit()

func _on_enemy_spawn():
	enemy_count += 1

func _on_battle_process():
	print('battleprocess')
	start_battle = true

func _on_battle_reset(amount: int):
	Global.wave_count += 1
	wave_size = amount
	enemy_count = 0
	start_battle = false
	processing_battle = false

func _on_enemy_destroyed():
	enemy_count -= 1

func _on_resolve():
	print('resolved')
