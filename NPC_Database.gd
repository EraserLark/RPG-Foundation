extends Node

var ow_npcPath:= "res://Overworld/Cast/OW_npc.tscn"

var list = {
	"Godot Guy": "res://Entity/NPC/GodotGuy.tres"
	}

func getInfo(npcName: String) -> NPC_Info:
	var resource = load(list[npcName])
	return resource

func createNPC(npcName: String, parent: CastList) -> OW_Actor:
	var ow_npc = load(ow_npcPath)		##Instantiate actor scene
	var inst = ow_npc.instantiate()
	var npcinfo = getInfo(npcName)		##Get npc info for actor
	inst.setNPCInfo(npcinfo)			##Set data for npc
	parent.add_child(inst)
	return inst
