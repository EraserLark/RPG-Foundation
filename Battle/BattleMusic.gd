extends AudioStreamPlayer2D

var tween: Tween

func fadeMusic(new_volume: float, duration: float):
	if tween and tween.is_running():
		tween.stop()
	tween = create_tween()
	
	tween.tween_method(setVolume, db_to_linear(volume_db), new_volume, duration)

func setVolume(vol: float) -> void:
	volume_db = linear_to_db(vol)
