extends AudioStreamPlayer2D

var tween: Tween

func fadeMusic(new_volume: float, duration: float):
	if tween and tween.is_running():
		tween.stop()
	tween = create_tween()
	
	#if !playing:
		#setVolume(0.0)
		#play()
		#tween.tween_method(setVolume, db_to_linear(volume_db), new_volume, duration)
	#else:
	tween.tween_method(setVolume, db_to_linear(volume_db), new_volume, duration)
		#tween.chain().tween_callback(stop)

func setVolume(vol: float) -> void:
	volume_db = linear_to_db(vol)
