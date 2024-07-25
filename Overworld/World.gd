extends Node2D

@onready var music:= $AudioStreamPlayer

func pauseWorld():
	music.stream_paused = true

func resumeWorld():
	music.stream_paused = false
