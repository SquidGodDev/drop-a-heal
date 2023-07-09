extends Control

var npcCount := 0

func _ready():
	updateNPCCount()

func updateNPCCount():
	$Label.text = "%03d" % npcCount


func _on_player_add_npc():
	npcCount += 1
	updateNPCCount()
	
func getNPCCount():
	return npcCount
