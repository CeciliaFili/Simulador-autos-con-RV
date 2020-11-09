extends Node

var state := {
	"connected": false,
	"driving": false,
	"id": 0
}
var command := {
	"up": false,
	"down": false,
	"left": false,
	"right": false
}

var payload := {
	"crash": false
}


var Car: PackedScene = preload("res://Scenes/Cars/Car 1.tscn")

# The port we will listen to
const PORT := 9080
# Our WebSocketServer instance
var _server := WebSocketServer.new()

func _ready():
	_server.connect("client_connected", self, "_connected")
	_server.connect("client_disconnected", self, "_disconnected")
	_server.connect("client_close_request", self, "_close_request")
	_server.connect("data_received", self, "_on_data")
	# Start listening on the given port.
	var err = _server.listen(PORT)
	print("WS STATUS CODE: ", err)
	if err != OK:
		print("Unable to start server")
		set_process(false)

func _connected(id, proto):
	print("Client %d connected with protocol: %s" % [id, proto])
	state.connected = true
	state.id = id

func _close_request(id, code, reason):
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])

func _disconnected(id, was_clean = false):
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])

func _on_data(id):
	var pkt = _server.get_peer(id).get_packet()
	#print("Got data from client %d: %s ... echoing" % [id, pkt.get_string_from_utf8()])
	var data = JSON.parse(pkt.get_string_from_utf8())
	if typeof(data.result) != TYPE_NIL:
		data = data.result
		command.up = data.up
		command.down = data.down
		command.left = data.left
		command.right = data.right

func _process(_delta):
	if state.connected:
		_server.get_peer(state.id).put_packet(JSON.print(payload).to_utf8())
	_server.poll()
