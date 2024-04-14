extends Node2D
@export var in_game: bool = false
@onready var menu = $Menu
@onready var game = $Game
@onready var menu_scores = $Menu/Scores
@onready var game_scores = $Game/Scores
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.scores_changed.connect(_on_scores_changed)
	menu_scores.text = " HIGH SCORE: %s\n SCORE: %s" % [to_text(Global.hi_score), to_text(Global.score)]
	game_scores.text = " SCORE: %s" % to_text(Global.score)
	if in_game:
		menu.visible= false
	else:
		game.visible=false

func _on_scores_changed():
	menu_scores.text = " HIGH SCORE: %s\n SCORE: %s" % [to_text(Global.hi_score), to_text(Global.score)]
	game_scores.text = " SCORE: %s" % to_text(Global.score)


func to_text(score:float):
	print("score ",score)
	var highmil = score>1000000
	var highkilo = score>1000
	var highscore_text = "%s" % score
	if highmil:
		highscore_text = "%s M" % (score/1000000)
	elif highkilo:
		highscore_text = "%s K" % (score/1000)
	return highscore_text
