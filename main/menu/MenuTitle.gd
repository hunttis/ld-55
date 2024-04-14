extends RichTextLabel

var character_cooldown = 0
var character_cooldown_max = 0.2

func _ready():
	visible_characters = 0

func _process(delta):
	character_cooldown -= delta
	if character_cooldown <= 0 && visible_characters < "FRUIT PUNCH".length():
		character_cooldown = character_cooldown_max
		Signals.create_vfx.emit(Global.VFX.SMOKE, Vector2(180 + 105 * visible_characters, 200))
		visible_characters += 1
