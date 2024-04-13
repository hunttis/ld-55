extends RichTextLabel

func _process(delta):
	if text != "[right]" + str(Global.score) + "[/right]":
		text = "[right]" + str(Global.score) + "[/right]"
