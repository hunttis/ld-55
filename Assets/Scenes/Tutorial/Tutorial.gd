extends Control

var tutorial_texts = {
	0: "Welcome to [GAME NAME]!\n(press space to continue)",
	1: "Help the tiny druids to defend their sanctuary from attacking monsters!\nUse E/F/J/I to control the druids and pour juice to summon allies.\n(press space to continue)",
	2: "Hold E/F/J/I down to start pouring juice to the summoning cap.\nTry to hit the target area!\nYour accuracy determines how strong of an ally you call forth.\n(press space to continue)",
	3: "Hitting closer to the target area also gives you more points\n(press space to continue)",
	4: "Have fun and good luck!\n(press space to start)"
}

@onready var tutorial_text = $Container/Panel/TutorialTextContainer/TutorialText

var tutorial_step = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.progress_tutorial.connect(_progress_tutorial)
	_progress_tutorial()
	Signals.disable_all_straws.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_progress_tutorial()
	

func _progress_tutorial():
	if tutorial_step == 4:
		Signals.start_game.emit()
		queue_free()
		return

	tutorial_step += 1
	tutorial_text.text = "[center]" + tutorial_texts[tutorial_step] + "[/center]"
