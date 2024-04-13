extends Node

@onready var rally_point = $RallyPoint

var summon_type = {
	Global.SUMMON.FRIENDLY1: Color.AQUA,
	Global.SUMMON.FRIENDLY2: Color.BROWN,
	Global.SUMMON.FRIENDLY3: Color.VIOLET
}

var friendly_count = 0

var friendly_scene: PackedScene = preload("res://Assets/Scenes/Friendly/Friendly.tscn")

func _ready():
	Signals.summon.connect(_on_summon)


func _on_summon(_summon: Global.SUMMON):
	var friendly = friendly_scene.instantiate()
	rally_point.add_child(friendly)
	friendly_count += 1
	friendly.position.x = friendly.position.x + friendly_count * (16 + 32)