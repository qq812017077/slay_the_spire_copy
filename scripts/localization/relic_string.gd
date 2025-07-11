class_name RelicString
extends Object

var NAME: String
var FLAVOR: String
var DESCRIPTIONS: Array = []

static func parse(keywords: Dictionary) -> RelicString:
	var relic_string = RelicString.new()

	var keys: Array = keywords.keys()
	for key in keys:
		if key in relic_string:
			# set the property of keywordString with the value from keywords
			relic_string.set(key, keywords[key])
		else:
			push_warning("Key '%s' not found in RelicString." % key)

	return relic_string