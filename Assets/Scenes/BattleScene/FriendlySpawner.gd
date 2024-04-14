extends Node

@onready var rally_point = $RallyPoint

var summon_type = {
	Global.SUMMON.FRIENDLY1: preload("res://Assets/Scenes/Friendly/Berry1.tscn"),
	Global.SUMMON.FRIENDLY2: preload("res://Assets/Scenes/Friendly/Berry2.tscn"),
	Global.SUMMON.FRIENDLY3: preload("res://Assets/Scenes/Friendly/Berry3.tscn"),
	Global.SUMMON.FRIENDLY4: preload("res://Assets/Scenes/Friendly/Berry4.tscn"),
	Global.SUMMON.FRIENDLY5: preload("res://Assets/Scenes/Friendly/Strawberry.tscn"),
}

var friendly_count = 0

func _ready():
	Signals.send_to_battlefield.connect(_on_summon)
	Signals.battle_resolved.connect(_on_battle_end)


func _on_summon(summon: Global.SUMMON):
	var friendly_scene = summon_type[summon]
	var friendly = friendly_scene.instantiate()
	rally_point.add_child(friendly)
	friendly_count += 1
	friendly.position.x = friendly.position.x + friendly_count * (16 + 32)
	Signals.arrived_to_battlefield.emit()

func _on_battle_end():
	friendly_count = 0
