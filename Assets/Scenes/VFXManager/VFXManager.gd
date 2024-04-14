extends Node

const CheerScene = preload("res://Assets/Scenes/CheerScene/CheerScene.tscn")

func _ready():
	Signals.create_vfx.connect(_on_create_vfx)

func _on_create_vfx(vfx: Global.VFX, position: Vector2):
	print("Signal received for: ", Global.VFX.keys()[vfx], " at position: ", position)
	match vfx:
		Global.VFX.CHEER_PERFECT, Global.VFX.CHEER_GOOD, Global.VFX.CHEER_BAD, Global.VFX.CHEER_MISS:
			print("Creating Cheer VFX")
			var cheer = CheerScene.instantiate()
			cheer.cheer_type = vfx
			get_parent().add_child(cheer)
			cheer.position = position


func _process(_delta):
	if Input.is_action_just_pressed("ui_left"):
		var new_vfx: Global.VFX = Global.VFX.values()[(randi_range(0, Global.VFX.size() - 1))]
		var position: Vector2 = Vector2(randi_range(0, 1280), randi_range(0, 720))
		print("Creating VFX: ", new_vfx, " at position: ", position)
		Signals.create_vfx.emit(new_vfx, position)


