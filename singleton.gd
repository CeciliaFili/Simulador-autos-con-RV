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
	"left_degree": 0.0,
	"right": false,
	"right_degree": 0.0
}

var payload := {
	"crash": false
}


var Car: PackedScene = preload("res://Scenes/Cars/Caterham/Caterham.tscn")
#var Car: PackedScene = preload("res://Scenes/Cars/Car 1.tscn")

# Automatic Server IP Detection
const UDP_BROADCAST_FREQUENCY: float = 3.0
var udp_network: PacketPeerUDP
var server_broadcasting_udp_port: int = 6868
var _broadcast_timer = 0

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
	
	udp_network = PacketPeerUDP.new()
	udp_network.set_broadcast_enabled(true)
	print("IP:", IP.get_local_addresses())


func _connected(id, proto):
	print("Client %d connected with protocol: %s" % [id, proto])
	state.connected = true
	state.id = id

func _close_request(id, code, reason):
	print("Client %d disconnecting with code: %d, reason: %s" % [id, code, reason])

func _disconnected(id, was_clean = false):
	print("Client %d disconnected, clean: %s" % [id, str(was_clean)])
	state.connected = false

func _on_data(id):
	var pkt = _server.get_peer(id).get_packet()
	var data = JSON.parse(pkt.get_string_from_utf8())
	if typeof(data.result) != TYPE_NIL:
		data = data.result
		command.up = data.up
		command.down = data.down
		command.left = data.left
		command.right = data.right
		command.right_degree = data.right_degree
		command.left_degree = data.left_degree


func _process(delta):
	if state.connected and payload.crash:
		_server.get_peer(state.id).put_packet(JSON.print(payload).to_utf8())
	_server.poll()

	if not state.connected:
		_broadcast_timer -= delta
		if _broadcast_timer <= 0:
			_broadcast_timer = UDP_BROADCAST_FREQUENCY

			for address in IP.get_local_addresses():
				var parts = address.split('.')
				if (parts.size() == 4):
					parts[3] = '255'
					udp_network.set_dest_address(parts.join('.'), server_broadcasting_udp_port)
					var error = udp_network.put_packet(address.to_ascii())
					if error == 1:
						print("Error while sending to ", address, ":", server_broadcasting_udp_port)
