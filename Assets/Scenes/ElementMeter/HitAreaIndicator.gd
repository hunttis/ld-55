extends Node2D

@onready var perfect_start: Sprite2D = $PerfectStart;
@onready var perfect_end: Sprite2D = $PerfectEnd;
@onready var good_start: Sprite2D = $GoodStart;
@onready var good_end: Sprite2D = $GoodEnd;
@onready var mediocre_start: Sprite2D = $MediocreStart;
@onready var mediocre_end: Sprite2D = $MediocreEnd;
@onready var target: Sprite2D = $Target;


func set_margin_indicators(perfect_margin: float, good_margin: float, mediocre_margin: float):
	perfect_start.global_position.x = global_position.x + perfect_margin
	perfect_end.global_position.x = global_position.x - perfect_margin
	good_start.global_position.x = global_position.x + good_margin
	good_end.global_position.x = global_position.x - good_margin
	mediocre_start.global_position.x = global_position.x + mediocre_margin
	mediocre_end.global_position.x = global_position.x - mediocre_margin
	target.global_position.x = global_position.x 
	if !Global.DEBUG:
		perfect_start.visible = false
		perfect_end.visible = false
		good_start.visible = false
		good_end.visible = false
		mediocre_start.visible = false
		mediocre_end.visible = false
