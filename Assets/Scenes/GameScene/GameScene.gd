extends Control

var tutorial: PackedScene = preload("res://Assets/Scenes/Tutorial/Tutorial.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.show_tutorial:
		var tutorial_inst = tutorial.instantiate()
		add_child(tutorial_inst)
	else:
		Signals.start_game.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
