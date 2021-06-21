extends Node

class_name Logger

var dir: Directory
var path: String 
var file: File
var prefix: String = "Null: "

func _init():
	self.dir = Directory.new()
	var _err = self.dir.open("user://HFPE/logs")
	if _err != OK:
		print("ERROR: failed to open file\n")
		print(String(_err))
	self.path = dir.get_current_dir()	
	self.file = File.new()
	self.file.open("user://HFPE/logs/log", File.WRITE)
	self.file.store_line("LogManager: Initialised!")
	
func write(string: String) -> void:
	self.file.store_line(prefix + string)
	
func flush() -> void:
	self.file.store_line("LogManager: Flushing file buffer (╯°□°）╯︵ ┻━┻")
	self.file.flush()
	
func set_prefix(new_prefix: String) -> void:
	self.prefix = new_prefix + ": "
	
func die() -> void:
	self.file.store_line("LogManager: Closing file")
	self.file.close()
	
