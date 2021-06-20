extends Node

class_name LogManager

var dir: Directory
var num_of_log_files: int = 0
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
	self.dir.list_dir_begin(true, true)
	while(true):
		var file = dir.get_next()
		if dir.file_exists(file):
			num_of_log_files += 1
		if file == "":
			dir.list_dir_end()
			break
			
	self.file = File.new()
	self.file.open("user://HFPE/logs/log%d" % num_of_log_files, File.WRITE)
	
func write(string: String) -> void:
	self.file.store_line(string)
	
func flush() -> void:
	self.file.store_line("LogManager: Flushing file buffer (╯°□°）╯︵ ┻━┻")
	self.file.flush()
	
func set_prefix(new_prefix: String) -> void:
	self.prefix = new_prefix + ": "
	
func die() -> void:
	self.file.store_line("LogManager: Closing file")
	self.file.close()
	
