#
# Texture's Atlas
#
class_name TextureAtlas
extends Object

var base_dir: String = "" # The base directory of the atlas file
var atlas_path: String = "" # The path to the atlas file
var textures_by_name: Dictionary = {} # String : Texture2D
var regions_by_name: Dictionary = {} # String : AtlasRegion

func find_region(region_name: String) -> AtlasRegion:
	# Find a region by its name
	if regions_by_name.has(region_name):
		return regions_by_name[region_name]
	else:
		push_error("Region not found: %s" % region_name)
		return null

static func load(_atlas_path: String) -> TextureAtlas:
	var file := FileAccess.open(_atlas_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open atlas file: %s" % _atlas_path)
		return null
	var content: String = file.get_as_text()
	var result = parse_atlas(_atlas_path.get_base_dir(), content)
	var atlas = TextureAtlas.new()
	atlas.atlas_path = _atlas_path
	atlas.base_dir = _atlas_path.get_base_dir()
	atlas.textures_by_name = result[0]
	atlas.regions_by_name = result[1]
	return atlas

static func parse_atlas(atlas_dir: String, atlas_data: String) -> Array:
	# replace all Windows line endings with Unix line endings
	atlas_data = atlas_data.replace("\r\n", "\n")
	var data_blocks: PackedStringArray = atlas_data.split("\n\n")

	var textures_by_name: Dictionary = {} # String : Texture2D
	var regions_by_name: Dictionary = {} # String : AtlasRegion
	
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

		var content_lines = Array(block.split("\n"))
		# remove empty lines until the first non-empty line
		while content_lines and space_regex.search(content_lines[0]):
			content_lines.pop_at(0)

		# each block represents data of an image sheet
		var filename = content_lines[0].strip_edges()
		if not filename.ends_with('.png'):
			push_error("Invalid filename format: %s" % filename)
			continue
		
		# create a texture2D via using the filename
		var file_path: String  = atlas_dir.path_join(filename)
		var texture: Texture2D = load(file_path)
		if texture == null:
			push_error("Failed to load texture: %s" % filename)
			continue
		textures_by_name.set(filename, texture)
		
		var cur_atlas_region: AtlasRegion = null
		for line in content_lines:
#			var global_attr_match: RegExMatch = global_attr_regex.search(line)
#			if global_attr_match:
#				var attr_key: String   = global_attr_match.get_string(1)
#				var attr_value: String = global_attr_match.get_string(2)
#				if attr_key == 'size':
#					var img_size = Vector2i(attr_value.split(',')[0].to_int(), attr_value.split(',')[1].to_int())
			if sprite_name_regex.search(line):
				if cur_atlas_region != null:
					regions_by_name.set(cur_atlas_region.name, cur_atlas_region)

				cur_atlas_region = AtlasRegion.new(texture)
				cur_atlas_region.name = line
			elif sprite_attr_regex.search(line):
				var sprite_attr_match: RegExMatch = sprite_attr_regex.search(line)
				var attr_key: String   = sprite_attr_match.get_string(1)
				var attr_value: String = sprite_attr_match.get_string(2)
				cur_atlas_region.set_attr(attr_key, attr_value)
		# whole block is read, save the last sprite
		regions_by_name.set(cur_atlas_region.name, cur_atlas_region)
		
	return [textures_by_name, regions_by_name]
