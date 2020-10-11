
extends Spatial

export (PackedScene) var Car

func _ready():
	var car = Car.instance()
	$Podium/Platform.add_child(car)

func focus_camera():
	$Camera_Point/Camera.current = true

func unfocus_camera():
	$Camera_Point/Camera.current = false
