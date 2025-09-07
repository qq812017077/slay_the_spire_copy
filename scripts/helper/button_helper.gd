class_name ButtonHelper


static func create_fit_button(target: Control, parent: Control = null) -> Button:
	var button: Button = Button.new()
	button.name = target.name + "_button"
	# set button size is fit target size
	button.size = target.size * target.scale
	button.position = target.position
	ThemeHelper.clean_button_style(button)
	if parent:
		parent.add_child(button)
	else:
		target.add_child(button)
		button.position = Vector2.ZERO
	return button

static func create_fit_button_from_sprite(target: Sprite2D, parent: Control = null) -> Button:
	var button: Button = Button.new()
	button.name = target.name + "_button"
	# set button size is fit target size
	button.size = target.texture.get_size() * target.scale
	
	ThemeHelper.clean_button_style(button)
	if parent:
		parent.add_child(button)
		if target.centered:
			button.position = target.position - target.texture.get_size() / 2 + target.offset
		else:
			button.position = target.position + target.offset
	else:
		target.add_child(button)
		button.position = Vector2.ZERO

		if target.centered:
			button.position = - target.texture.get_size() / 2 + target.offset
		else:
			button.position = target.offset
	return button
