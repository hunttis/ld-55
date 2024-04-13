extends Control


func _on_home_body_entered(body:Node2D):
	if body is Enemy:
		body.queue_free()
		# TODO: emit damage signal

func _on_friendly_timer_timeout():
	Signals.summon.emit(Global.SUMMON.values()[randi()%Global.SUMMON.size()])