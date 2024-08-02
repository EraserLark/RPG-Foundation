extends Node2D

@onready var music:= $AudioStreamPlayer
@onready var csManager:= $CutsceneManager

func pauseWorld():
	music.stream_paused = true

func resumeWorld():
	music.stream_paused = false
