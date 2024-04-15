extends Node

const CheerScene = preload("res://Assets/Scenes/VFXManager/CheerVFX/CheerScene.tscn")
const SmokeScene = preload("res://Assets/Scenes/VFXManager/SmokeVFX/SmokeScene.tscn")
const CrashScene = preload("res://Assets/Scenes/VFXManager/CrashVFX/CrashScene.tscn")
const MuteScene = preload("res://Assets/Scenes/VFXManager/SoundVFX/MuteScene.tscn")
const SummonScene = preload("res://Assets/Scenes/VFXManager/SummoningVFX/SummoningScene.tscn")
const LiquidScene = preload("res://Assets/Scenes/VFXManager/LiquidVFX/LiquidVFX.tscn")
const BattleFxScene = preload("res://Assets/Scenes/VFXManager/BattleVFX/BattleScene.tscn")
const HighlightScene = preload("res://Assets/Scenes/VFXManager/HighlightVFX/HighlightScene.tscn")

func _ready():
	Signals.create_vfx.connect(_on_create_vfx)

func _on_create_vfx(vfx: Global.VFX, position: Vector2):
	match vfx:
		Global.VFX.CHEER_PERFECT, Global.VFX.CHEER_GOOD, Global.VFX.CHEER_BAD, Global.VFX.CHEER_MISS:
			var cheer = CheerScene.instantiate()
			cheer.cheer_type = vfx
			get_parent().add_child(cheer)
			cheer.position = position
		Global.VFX.SMOKE:
			var smoke = SmokeScene.instantiate()
			get_parent().add_child(smoke)
			smoke.position = position
		Global.VFX.CRASH:
			var crash = CrashScene.instantiate()
			get_parent().add_child(crash)
			crash.position = position
		Global.VFX.MUTE:
			var mute_fx = MuteScene.instantiate()
			mute_fx.sounds_on = false
			get_parent().add_child(mute_fx)
			mute_fx.position = position
		Global.VFX.SOUNDS_ON:
			var mute_fx = MuteScene.instantiate()
			mute_fx.sounds_on = true
			get_parent().add_child(mute_fx)
			mute_fx.position = position
		Global.VFX.SUMMON:
			var summon = SummonScene.instantiate()
			get_parent().add_child(summon)
			summon.position = position
		Global.VFX.APPLE_JUICE, Global.VFX.ONION_JUICE, Global.VFX.PEAR_JUICE, Global.VFX.ORANGE_JUICE:
			var liquid = LiquidScene.instantiate()
			get_parent().add_child(liquid)
			liquid.position = position
			liquid.element = vfx
		Global.VFX.BATTLE_DAMAGE:
			var battle_fx = BattleFxScene.instantiate()
			get_parent().add_child(battle_fx)
			battle_fx.position = position
		Global.VFX.HIGHLIGHT:
			var highlight_fx = HighlightScene.instantiate()
			get_parent().add_child(highlight_fx)
			highlight_fx.global_position = position
			
		
func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		var new_vfx: Global.VFX = Global.VFX.values()[(randi_range(0, Global.VFX.size() - 1))]
		var position: Vector2 = Vector2(randi_range(0, 1280), randi_range(0, 720))
		print("Creating VFX: ", new_vfx, " at position: ", position)
		Signals.create_vfx.emit(new_vfx, position)


