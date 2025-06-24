class_name Keyword
extends Object

var DESCRIPTION: String
var NAMES: Array


static func parse(data: Dictionary) -> Keyword:
	var keyword = Keyword.new()

	var keys: Array = data.keys()
	for key in keys:
		if key in keyword:
			# set the property of keywordString with the value from keywords
			keyword.set(key, data[key])
		else:
			push_warning("Key '%s' not found in KeywordString." % key)
	
	if not keyword.NAMES or keyword.NAMES.size() == 0:
		push_error("Keyword has no names: " + str(data))
	
	return keyword
