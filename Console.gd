# Singleton console printer with style!
# Ryan Scott © 2024
# Additional Documentation: https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html

extends Node
var more_than_one_effect:bool = false


# Applies effects
func pretty_print(text:String, effects:Array[String]):
	var final_output = text
	more_than_one_effect = true # Disables individual prints for the upcoming pretty print
	
	# Apply each effect in list of effects "recursively"
	for effect in effects:
		if effect.contains("align") or effect.contains("left") or effect.contains("right") or effect.contains("center") or effect.contains("fill"): 
			final_output = print_aligned(final_output, effect.split(" ")[-1])
		if effect.contains("font"): final_output = print_font(final_output, effect.split(" ")[-1])
		if effect.contains("bold"): final_output = print_bold(final_output)
		if effect.contains("ital"): final_output = print_italic(final_output)
		if effect.contains("strike"): final_output = print_strikethrough(final_output)
		if effect.contains("under"): final_output = print_underline(final_output)
		if effect.contains("size"): final_output = print_size(final_output, effect.split(" ")[-1])
		if effect.contains("color"): final_output = print_color(final_output, effect.split(" ")[-1])
		if effect.contains("bgcolor"): final_output = print_bg_color(final_output, effect.split(" ")[-1])
		if effect.contains("fgcolor"): final_output = print_fg_color(final_output, effect.split(" ")[-1])
		if effect.contains("rainbow"): final_output = print_rainbow(final_output)
		if effect.contains("wav"): final_output = print_wavy(final_output)
		if effect.contains("shak"): final_output = print_shake(final_output)
		if effect.contains("indent"): final_output = print_indented(final_output)
		if effect.contains("image"): final_output = print_img(final_output)
		if effect.contains("fade"): final_output = print_fade(final_output)
		if effect.contains("pulse"): final_output = print_pulse(final_output)
	
	# Pretty print complete
	print_rich(final_output)
	more_than_one_effect = false


#region Functions for Print Effects
# Changes text color
func print_color(text, color:String):
	var result
	
	if color.contains("color"): # Color label is in arg
		result = "[%s]%s[/color]" % [color, text]
	else: # Color label is NOT in arg, add it
		result = "[color=%s]%s[/color]" % [color, text]
	
	return print_or_return(result)


# Changes text font
func print_font(text, font_location):
	var result = "[font=%s]%s[/font]" % [font_location, text]
	return print_or_return(result)


# Makes text bigger/smaller
func print_size(text, size):
	var result = "[font_size=%s]%s[/font_size]" % [size, text]
	return print_or_return(result)


# Makes text wavy
func print_wavy(text, amp = 50.0, freq = -5.0):
	var result = "[wave amp=%f freq=%f connected=1]%s[/wave]" % [amp, freq, text]
	return print_or_return(result)


# Makes text pulse
func print_pulse(text, freq = 2.5):
	var result = "[pulse freq=%f connected=1]%s[/pulse]" % [freq, text]
	return print_or_return(result)


# Makes text rainbow!
func print_rainbow(text):
	var result = "[rainbow freq=1.0 sat=0.8 val=0.8]%s[/rainbow]" % [text]
	return print_or_return(result)
	

# Makes text bold!
func print_bold(text):
	var result = "[b]%s[/b]" % [text]
	return print_or_return(result)
	
	
# Makes text italic!
func print_italic(text):
	var result = "[i]%s[/i]" % [text]
	return print_or_return(result)
	
	
# Makes text underline!
func print_underline(text):
	var result = "[u]%s[/u]" % [text]
	return print_or_return(result)


# Makes text strikethrough!
func print_strikethrough(text):
	var result = "[s]%s[/s]" % [text]
	return print_or_return(result)
	

# Makes text shake
func print_shake(text, shake_rate = 20.0, level = 5):
	var result = "[shake rate=%f level=%f connected=1]%s[/shake]" % [shake_rate, level, text]
	return print_or_return(result)


# Aligns text left, right, center, or fill
func print_aligned(text, alignment):
	# Left, Center, Right, Fill
	var options = ["left", "right", "center", "fill"]
	if not options.has(alignment): alignment = options[0]
	
	var result = "[%s]%s[/%s]" % [alignment, text, alignment]
	return print_or_return(result)


# Indents # of times (default 1)
func print_indented(text, amt_of_indents:int = 1):
	var result = text
	for i in range(amt_of_indents):
		result = ("%s" + result + "%s") % ["[indent]", "[/indent]"]

	return print_or_return(result)


# Creates url
func print_url(text):
	var result = "[url]%s[/url]" % [text]
	return print_or_return(result)


# Draws color behind text
func print_bg_color(text, color):
	var result
	
	if color.contains("bgcolor="): # Color label is in arg
		result = "[%s]%s[/bgcolor]" % [color, text]
	else: # Color label is NOT in arg, add it
		result = "[bgcolor=%s]%s[/bgcolor]" % [color, text]
	
	return print_or_return(result)


func print_fade(text, fade_start = 20, length = 24):
	var result = "[fade fade_start=%s length=%s]%s[/fade]" % [fade_start, length, text]
	return print_or_return(result)


# Draws image
func print_img(path_to_img):
	var result = "%s%s%s" % ["[img]", path_to_img, "[/img]"]
	return print_or_return(result)


# Draws color in front of text, can be used for redacting
func print_fg_color(text, color):
	var result
	
	if color.contains("fgcolor="): # Color label is in arg
		result = "[%s]%s[/fgcolor]" % [color, text]
	else: # Color label is NOT in arg, add it
		result = "[fgcolor=%s]%s[/fgcolor]" % [color, text]
	
	return print_or_return(result)
#endregion


# Determines if individual print or group of effects
func print_or_return(result):
	if not more_than_one_effect: # Not part of bigger pretty print...
		print_rich(result)       # So print result directly instead!
	else: return result          # Otherwise, continue to dress up pretty print!
	

# Runs a pretty demo of pretty print :)
func demo():
	# Color, Bold, Italic, Underline, Strikethrough, Size
	pretty_print("This log is red and bold!", ["color= red", "bold"])
	pretty_print("This log is orange and italic underlined!", ["color= orange", "italic", "underline"])
	pretty_print("This log is big & crossed out!", ["color= CORNFLOWER_BLUE", "striked", "size = 30"])
	
	# Cool animated effects
	pretty_print("This log is tasting the rainbow!", ["rainbow"])
	pretty_print("This log is cool and wavey!", ["wavey"])
	pretty_print("UH OH! THIS LOG IS SHAKING!", ["shakey", "color = red", "bold", "bgcolor = black", "pulse"])
	
	# Spacing
	pretty_print("This log is indented!", ["indent"])
	pretty_print("This log is aligned left", ["left"])
	pretty_print("This log is aligned fill", ["fill"])
	pretty_print("This log is aligned center", ["center"])
	pretty_print("This log is aligned right", ["align = right"])
	
	# Change fonts, use images
	pretty_print("This  log  is  extremely  pretty!", ["rainbow", "size = 35", "wavey", "font = res://Assets/Fonts/kenvector_future_thin.ttf", "center"])
	pretty_print("",[])
	pretty_print("This log is an image:", ["bold", "center"])
	pretty_print("res://icon.svg", ["image", "center"])
	pass
