extends Spatial

var angle = 0.005
var car_zone2 = false

func _ready():
	pass # Replace with function body

func _process(delta):	
	rotation()

		
func rotation():
	rotate_object_local(Vector3(0,1, 0),angle)
	transform = transform.orthonormalized()
	transform = transform.scaled(scale)


