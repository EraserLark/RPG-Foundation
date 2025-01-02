extends Node

func muteBus(busName: String):
	var bus_id = AudioServer.get_bus_index(busName)
	AudioServer.set_bus_mute(bus_id, true)

func unmuteBus(busName: String):
	var bus_id = AudioServer.get_bus_index(busName)
	AudioServer.set_bus_mute(bus_id, false)

func setBusVolume(busName: String, linearVolume: float):
	var bus_id = AudioServer.get_bus_index(busName)
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(linearVolume))
	
	#If vol is set imperceptibly low, go ahead and mute it
	if linearVolume < .05:
		muteBus(busName)
