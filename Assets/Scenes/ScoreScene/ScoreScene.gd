extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.scores_changed.connect(_on_scores_changed)
	text = "HIGH SCORE: %s\nSCORE: %s" % [Global.hi_score, Global.score]


func _on_scores_changed():
	text = "HIGH SCORE: %s\nSCORE: %s" % [Global.hi_score, Global.score]
	print("SCORES, ",Global.hi_score, " ", Global.score)
