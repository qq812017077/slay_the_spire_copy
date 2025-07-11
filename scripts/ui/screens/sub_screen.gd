class_name MenuSubScreen
extends Control

var confirm_click_event: Callable
var cancel_click_event: Callable


func open(confirm_event: Callable = Callable(), cancel_event: Callable = Callable()) -> void:
	self.show()
	confirm_click_event = confirm_event
	cancel_click_event = cancel_event

func close() -> void:
	CardGame.main_menu_screen.is_super_darken = false
	hide()