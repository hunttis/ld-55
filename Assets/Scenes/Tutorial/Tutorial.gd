extends Control

var tutorial_texts = {
	0: "Welcome to [GAME NAME]",
	1: "Press [THE FIRST KEY] down to start accumulating mana.\n Release to stop. Try to hit the target area.",
	2: "Hitting closer to the target area gives you more points"
}

@onready var tutorial_text = $TutorialTextContainer/TutorialText

var tutorial_step = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.progress_tutorial.connect(_progress_tutorial)
	_progress_tutorial()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_text_backspace"):
		_progress_tutorial()
	

func _progress_tutorial():
	tutorial_step += 1
	tutorial_text.text = "[center]" + tutorial_texts[tutorial_step] + "[/center]"
