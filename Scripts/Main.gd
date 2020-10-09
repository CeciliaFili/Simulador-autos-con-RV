extends Spatial


func _ready():
	pass
	
func _on_Concesionaria_Model_1():
	if Input.is_action_just_pressed("ui_e"):
		get_tree().change_scene("res://Scenes/Driving.tscn")
		


func _on_Concesionaria_Model_2():
	if Input.is_action_just_pressed("ui_e"):
		get_tree().change_scene("res://Scenes/Driving.tscn")
		

