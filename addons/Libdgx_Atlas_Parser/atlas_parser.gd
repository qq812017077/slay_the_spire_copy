@tool
extends Panel

var editor_interface: EditorInterface

var dragArea: Control
var load_button: Button
var clear_button: Button
var parser_button: Button
var load_file_dialog: FileDialog
var progressBar : ProgressBar

var is_working: bool = false
var output_path: String = ""
var atlas_sheet_data: Array
var cur_sprites_data: Array = []
var cur_sheet: SheetData
var cur_sheet_image: Image
var step: int = 0
var total: int = 0
func _ready() -> void:
	dragArea = $VBoxContainer/DragArea
	load_button = $VBoxContainer/LoadButton
	clear_button = $VBoxContainer/ClearButton
	parser_button = $VBoxContainer/ParserButton
	progressBar = $VBoxContainer/ProgressBar
	load_button.pressed.connect(load_pressed)
	clear_button.pressed.connect(clear_pressed)
	parser_button.pressed.connect(parser_pressed)
	
	load_file_dialog = $LoadFileDialog
	load_file_dialog.file_selected.connect(load_file_selected)
	
func _process(_delta: float) -> void:
	progressBar.visible = is_working
	if is_working:
		progressBar.value = float(step) / float(total) * 100
		if dragArea: dragArea.visible = false
		if load_button: load_button.disabled = true
		if clear_button: clear_button.disabled = true
		if parser_button: parser_button.disabled = true
		deal_with_data()
	else:
		if $VBoxContainer/LabelContainer/FilePath.text != "":
			if dragArea: dragArea.visible = false
			if load_button: load_button.disabled = true
			if clear_button: clear_button.disabled = false
			if parser_button: parser_button.disabled = false
		else:
			if dragArea: dragArea.visible = true
			if load_button: load_button.disabled = false
			if clear_button: clear_button.disabled = true
			if parser_button: parser_button.disabled = true

func load_pressed() -> void:
	$LoadFileDialog.popup_centered_ratio()
	
func clear_pressed() -> void:
	$VBoxContainer/LabelContainer/FilePath.text = ""


func rmdir(directory: String) -> void:
	for file in DirAccess.get_files_at(directory):
		DirAccess.remove_absolute(directory.path_join(file))
	for dir in DirAccess.get_directories_at(directory):
		rmdir(directory.path_join(dir))
	DirAccess.remove_absolute(directory)
	

	
func parser_pressed() -> void:
	var path = $VBoxContainer/LabelContainer/FilePath.text
	# load file 
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: %s" % path)
		return
		
	var content = file.get_as_text()
	atlas_sheet_data = LibdgxAtlasParser.parse_atalas(content)
	output_path = path.split(".")[0]
	# if output path is a directory, delete it
	var out_dir: DirAccess = DirAccess.open(output_path)
	if out_dir != null:
		rmdir(output_path)
	
	total = 0
	for sheet in atlas_sheet_data:
		total += sheet.sprites_data.size()
	step = 0
	
	is_working = true
	
	# single processing
#	for sheet in atlas_sheet_data:
#		print("Sheet: ", sheet.filename, " Size: ", sheet.size)
#		var sheet_path = path.get_base_dir().path_join(sheet.filename)
#		# load the image
#		var sheet_image: Image = Image.load_from_file(sheet_path)
#		print("Image height: ", sheet_image.get_height())
#		print("Image width: ", sheet_image.get_width())
#		print("Image format: ", sheet_image.get_format())
#		if not sheet_image:
#			push_error("Failed to load image: %s" % sheet_path)
#			continue
#		for sprite in sheet.sprites_data:
#			parse_sprite(output_path, sheet, sheet_image, sprite)

func deal_with_data(count: int = 1) -> void:
	if atlas_sheet_data.size() == 0:
		is_working = false
		return 
	
	while count > 0 and atlas_sheet_data.size() > 0:
		if cur_sheet == null:
			cur_sheet = atlas_sheet_data[0]
			cur_sprites_data = Array(cur_sheet.sprites_data)
			var sheet_path = $VBoxContainer/LabelContainer/FilePath.text.get_base_dir().path_join(cur_sheet.filename)
			cur_sheet_image = Image.load_from_file(sheet_path)
		
		if cur_sprites_data.size() == 0:
			atlas_sheet_data.pop_at(0)
			cur_sheet = null
			cur_sprites_data = []
			cur_sheet_image = null
			continue
		
		var cur_sprite : SpriteData = cur_sprites_data[0]
		cur_sprites_data.pop_at(0)
		parse_sprite(output_path, cur_sheet, cur_sheet_image, cur_sprite)
		step += 1
		count -= 1
		
#			var sprite_image: Image = Image.create(sprite.orig.x,sprite.orig.y, false, sheet_image.get_format())
#			# get cropped region of the sprite
#			var sprite_region: Rect2i = Rect2i(sprite.xy, sprite.size)
#			# crop the sheet image
#			sprite_image.blend_rect(sheet_image, sprite_region, sprite.offset)
#			if sprite.rotate:
#				# rotate the sprite image
#				push_error("Sprite rotation is not implemented yet.")
#				continue
#
#			var dir: DirAccess  = DirAccess.open(sheet.filename.get_base_dir())
#			var sprite_filename = "%s.png" % sprite.name
#			sprite_filename = output_path.path_join(sprite_filename)
#			var sprite_filename_dir = sprite_filename.get_base_dir().replace("res://", "")
#			# if directory does not exist, create it
#			if not dir.dir_exists(sprite_filename_dir):
#				var result: int = dir.make_dir_recursive(sprite_filename_dir)
#				if result != OK:
#					push_error("Failed to create directory: %s" % sprite_filename_dir)
#					continue
#			
#			var result = sprite_image.save_png(sprite_filename)
#			if result != OK:
#				push_error("Failed to save sprite image: %s" % sprite_filename)
#			else:
#				print("Saved sprite image: ", sprite_filename)
	
func parse_sprite(output_path: String, sheet: SheetData, sheet_image: Image, sprite: SpriteData)-> void:
	var sprite_image: Image = Image.create(sprite.orig.x,sprite.orig.y, false, sheet_image.get_format())
	# get cropped region of the sprite
	var sprite_region: Rect2i = Rect2i(sprite.xy, sprite.size)
	# crop the sheet image
	sprite_image.blend_rect(sheet_image, sprite_region, sprite.offset)
	if sprite.rotate:
		# rotate the sprite image
		push_error("Sprite rotation is not implemented yet.")
		return

	var dir: DirAccess          = DirAccess.open(sheet.filename.get_base_dir())
	var sprite_filename: String = "%s.png" % sprite.name
	sprite_filename = output_path.path_join(sprite_filename)
	var sprite_filename_dir: String = sprite_filename.get_base_dir().replace("res://", "")
	# if directory does not exist, create it
	if not dir.dir_exists(sprite_filename_dir):
		var result: int = dir.make_dir_recursive(sprite_filename_dir)
		if result != OK:
			push_error("Failed to create directory: %s" % sprite_filename_dir)
			return

	var result: int = sprite_image.save_png(sprite_filename)
	if result != OK:
		push_error("Failed to save sprite image: %s" % sprite_filename)
	else:
		print("Saved sprite image: ", sprite_filename)			
func load_file_selected(path: String) -> void:
	print("File selected: ", path)
	$VBoxContainer/LabelContainer/FilePath.text = path

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	var rect = dragArea.get_rect()
#	print(data)
	return rect.has_point(at_position)

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var target_file: String = data['files'][0]
	if target_file.ends_with('.atlas'):
		$VBoxContainer/LabelContainer/FilePath.text = target_file
	else:
		print("Invalid file type. Please drop a .atlas file.")
		return
