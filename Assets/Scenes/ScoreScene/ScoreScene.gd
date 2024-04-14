extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.scores_changed.connect(_on_scores_changed)
	text = "HIGH SCORE: %s\nSCORE: %s" % [to_text(Global.hi_score), to_text(Global.score)]


func _on_scores_changed():
	text = "HIGH SCORE: %s\nSCORE: %s" % [to_text(Global.hi_score), to_text(Global.score)]


func to_text(score:float):
	print("score ",score)
	var highmil = score>1000000
	var highkilo = score>1000
	var highscore_text = "%s" % score
	if highmil:
		highscore_text = "%sM" % (score/1000000)
	elif highkilo:
		highscore_text = "%sK" % (score/1000)
	return highscore_text
