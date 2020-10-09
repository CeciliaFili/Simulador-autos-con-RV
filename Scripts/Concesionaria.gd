extends Spatial
signal Model_1
signal Model_2

func _ready():
	pass # Replace with function body.


func _on_Model_1_body_entered(body):
	emit_signal("Model_1")


func _on_Model_2_body_entered(body):
	emit_signal("Model_2")
