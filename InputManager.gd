extends Node
##INPUT MANAGER

signal newPlayerJoined(joypadNum: int)
signal playerLeft(joypadNum: int)

func _ready() -> void:
	Input.joy_connection_changed.connect(connectionChanged)

func _process(delta: float) -> void:
	pass

func connectionChanged(device: int, connected: bool):
	var joypadCount:= Input.get_connected_joypads().size()
	
	if(joypadCount <= 0):
		printerr("No joypads connected!")
		#return
	
	print("Controllers: \n")
	for joypad in joypadCount:
		print(str(joypad, ": ", Input.get_joy_name(joypad), "\n"))
	
	if(connected):
		emit_signal("newPlayerJoined", device)
		#Create empty entry in PlayerRoster
		#Adjust current Player UIs to fit new anchors
		#Player selects info from list of profiles or creates new profile
		#Once info is selected, PlayerRoster creates PlayerEntity and adds them to the scene
	elif(!connected):
		emit_signal("playerLeft", device)
		#If that player is still in Roster (did not leave. Still trying to play but controller disconnected)
		#Pause game?
		#Or do a static effect menu saying controller disconnected?
		#Else if player already left roster (Manually)
		#
