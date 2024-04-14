extends Node

signal play_button_pressed
signal sounds_toggled
signal after_sounds_toggled

signal reset_all_taps

signal button_released(button_type)
signal button_pressed(button_type)

signal progress_tutorial

signal get_hurt
signal add_score(amount)

signal game_over
signal to_main_menu

signal battle_start
signal battle_resolved
signal spawn_start

signal summoning_complete(summon: Global.SUMMON)
signal send_to_battlefield(summon: Global.SUMMON)
signal arrived_to_battlefield()
signal total_fup()

signal battle_init(wave_size: int)
signal battle_process
signal enemy_spawned
signal enemy_destroyed

signal disable_all_straws()
signal pick_new_straws()

signal create_vfx(vfx: Global.VFX, position: Vector2)
