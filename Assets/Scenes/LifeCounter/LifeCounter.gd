extends Node2D

@onready var counter_scene: PackedScene = preload("res://Assets/Scenes/LifeCounter/LifeCounterCan.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.get_hurt.connect(_on_get_hurt)

func _on_get_hurt():
	var children = get_children()
	if children.size() > 0:
		children[children.size()-1].queue_free()