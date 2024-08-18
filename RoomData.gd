@tool
extends Resource
class_name RoomData

var room: Room
@export var castList: Array[String]
@export var passageList: Array[String]
@export var cutsceneMarks: Array[String]

@export var zone: String
@export var roomName: String

func clearData():
	room = null
	castList.clear()
	passageList.clear()
	cutsceneMarks.clear()
