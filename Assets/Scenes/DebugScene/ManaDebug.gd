extends VBoxContainer

@onready var air_mana_label: Label = $AirMana
@onready var water_mana_label: Label = $WaterMana
@onready var fire_mana_label: Label = $FireMana
@onready var earth_mana_label: Label = $EarthMana

func _process(_delta):
	if (air_mana_label.text != "air_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.PEAR], 0.01))):
		air_mana_label.text = "air_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.PEAR], 0.01))
	if (water_mana_label.text != "water_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.ORANGE], 0.01))):
		water_mana_label.text = "water_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.ORANGE], 0.01))
	if (fire_mana_label.text != "fire_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.ONION], 0.01))):
		fire_mana_label.text = "fire_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.ONION], 0.01))
	if (earth_mana_label.text != "earth_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.APPLE], 0.01))):
		earth_mana_label.text = "earth_mana_label: " + str(snapped(Global.mana[Global.ELEMENT.APPLE], 0.01))
