tool
extends Path

export var track_width = 8.0 setget set_track_width, get_track_width
export var lower_ground_width = 12.0 setget set_lower_ground_width, get_lower_ground_width


var is_dirty = true

func set_track_width(new_width):
	if track_width != new_width:
		track_width = new_width
		is_dirty = true
		call_deferred("_update")

func get_track_width():
	return track_width

func set_lower_ground_width(new_width):
	if lower_ground_width != new_width:
		lower_ground_width = new_width
		is_dirty = true
		call_deferred("_update")

func get_lower_ground_width():
	return lower_ground_width

func _update():
	if !is_dirty:
		return
	
	# how long is our track?
	var curve_length = curve.get_baked_length()
	
	###################################################################################
	# update our track
	var track_half_width = track_width * 0.5
	var ground_half_width = lower_ground_width * 0.5
	
	var track = $Road.polygon
	track.set(0, Vector2(-track_half_width, 0.0))
	track.set(1, Vector2(-track_half_width, -0.1))
	track.set(2, Vector2( track_half_width, -0.1))
	track.set(3, Vector2( track_half_width, 0.0))
	$Road.polygon = track
	
	var ground = $Ground.polygon
	ground.set(1, Vector2( track_half_width + 2.0, -0.1))
	ground.set(0, Vector2(-track_half_width - 2.0, -0.1))
	ground.set(2, Vector2( lower_ground_width, -4.01))
	ground.set(3, Vector2( lower_ground_width + 0.1, -4.1))
	ground.set(4, Vector2(-lower_ground_width - 0.1, -4.1))
	ground.set(5, Vector2(-lower_ground_width, -4.0))
	$Ground.polygon = ground
	
	###################################################################################
	
	

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_update")

func _on_Path_curve_changed():
	is_dirty = true
	call_deferred("_update")
