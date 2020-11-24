extends ARVROrigin

export var max_distance = 0.3
var reset_time = 2.0
var alpha = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Android":
		var interface = ARVRServer.find_interface("OpenVR")
		if interface and interface.initialize():
			get_viewport().arvr = true
			get_viewport().hdr = false
