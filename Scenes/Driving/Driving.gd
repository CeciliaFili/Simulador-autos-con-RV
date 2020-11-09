extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Singleton.state.driving = true
	var car := Singleton.Car.instance()
	car.translation = $CarPoint.translation
	add_child(car)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
