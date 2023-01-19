extends Control

var word_count = 0
signal ready_done

func _ready():
	$READY.visible = false
	$SET.visible = false
	$GO.visible = false
	
func _process(delta):
	if word_count == 1:
		$READY.visible = true
		if $Timer.is_stopped():
			$Timer.start()
	if word_count == 2:
		$SET.visible = true
		if $Timer.is_stopped():
			$Timer.start()
	if word_count == 3:
		$GO.visible = true
		yield(get_tree().create_timer(2), "timeout")
		emit_signal("ready_done")

func _on_Timer_timeout():
	word_count += 1

