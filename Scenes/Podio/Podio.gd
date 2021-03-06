
extends Spatial

export (PackedScene) var Car

func _ready():
	var car = Car.instance()
	car.translation = $Podium/Platform/CarPoint.translation
	$Podium/Platform.add_child(car)

func focus_camera():
	$Camera_Point/Camera.current = true
	Singleton.Car = Car

func unfocus_camera():
	$Camera_Point/Camera.current = false
	Singleton.Car = Car
