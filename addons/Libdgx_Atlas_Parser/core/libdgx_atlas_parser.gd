class_name LibdgxAtlasParser
extends Object

static func parse_atalas(atlas_data: String) -> Array:
	# replace all Windows line endings with Unix line endings
	atlas_data = atlas_data.replace("\r\n", "\n")
	var data_blocks = atlas_data.split("\n\n")
	
	var parsed_data = []
	
	var space_regex: RegEx = RegEx.new()
	var global_attr_regex : RegEx= RegEx.new()
	var sprite_name_regex : RegEx= RegEx.new()
	var sprite_attr_regex : RegEx= RegEx.new()
	space_regex.compile("^\\s*$")
	global_attr_regex.compile("^([a-z]+): (.+)$")
	sprite_name_regex.compile("^[a-zA-Z0-9-_\\/]+$")
	sprite_attr_regex.compile("^ +([a-z]+): (.+)$")
	
	for block in data_blocks:
		if block == '':
			continue
		else:
			var content_lines = Array(block.split("\n"))

			# remove empty lines until the first non-empty line
			while content_lines and space_regex.search(content_lines[0]):
				content_lines.pop_at(0)

			# each block represents data of an image sheet
			var sheet_data: SheetData = SheetData.new()
			sheet_data.filename = content_lines[0].strip_edges()
#			print("sheet_data filename: %s" % sheet_data.filename)
			if not sheet_data.filename.ends_with('.png'):
				push_error("Invalid filename format: %s" % sheet_data.filename)
				continue
			
			var current_sprite: SpriteData = null
			for line in content_lines:
				var global_attr_match: RegExMatch = global_attr_regex.search(line)
				if global_attr_match:
					var attr_key: String   = global_attr_match.get_string(1)
					var attr_value: String = global_attr_match.get_string(2)
					if attr_key == 'size':
						sheet_data.size = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
#						print("global_attr: %s" % sheet_data.size)
				elif sprite_name_regex.search(line):
					if current_sprite != null:
						sheet_data.add_sprite(current_sprite)
					
					current_sprite = SpriteData.new()
					current_sprite.name = line
#					print("current_sprite names: ", line)
				elif sprite_attr_regex.search(line):
					var sprite_attr_match: RegExMatch = sprite_attr_regex.search(line)
					var attr_key: String   = sprite_attr_match.get_string(1)
					var attr_value: String = sprite_attr_match.get_string(2)
					if attr_key == 'rotate':
#						print("sprite_attr: %s = %s" % [attr_key, attr_value == "true"])
						current_sprite.rotate = attr_value == "true"
					elif attr_key == 'xy':
						current_sprite.xy = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
					elif attr_key == 'size':
						current_sprite.size = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
					elif attr_key == 'offset':
						current_sprite.offset = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
					elif attr_key == 'orig':
						current_sprite.orig = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
					elif attr_key == 'index':
						if attr_value != '-1':
							current_sprite.name += '.' + attr_value
					else:
						push_error("Unrecognized sprite attribute: %s" % line)
				
			
			# whole block is read, save the last sprite
			sheet_data.add_sprite(current_sprite)

			# add this sheet to the list
			parsed_data.append(sheet_data)
	return parsed_data
