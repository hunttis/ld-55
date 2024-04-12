extends Control


func _ready():
	print("main_menu ready")
	$MenuItems/TitleContainer/MenuTitle.text = Global.NAME_OF_THE_GAME

func _process(delta):
	pass
