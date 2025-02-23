extends Node

@onready var background_table: Control = $Background/Table

func _ready():
	var columns = ["Team", "Won", "Lost"]
	var data = [
		["NYC", 3, 1],
		["LOS", 2, 3],
		["PHI", 3, 2],
		["TEX", 4, 0],
		["DET", 0, 3],
		["DEN", 1, 3],
	]
	
	var df = DataFrame.New(data, columns)
	
	var total = DataFrame.EvalColumns(
		df.GetColumn("Won"),
		"+",
		df.GetColumn("Lost")
	)
	df.AddColumn(total, "Total")
	
	var pct = DataFrame.EvalColumns(
		df.GetColumn("Won"),
		"/",
		df.GetColumn("Total"),
		true
	)
	df.AddColumn(pct, "Pct")
	
	df.SortBy("Pct", true)
	
	print(df)
	
	background_table.data = df
	background_table.Render()
	
	print(1 / 4)
	print(3 / 2)
	print(1.0 / 4.0)
	
#	print(total)
	
	#df.AddColumn(
		#[4, 5, 5, 4, 3, 4],
		#"Total"
	#)
	#
	#print(df)
	#
	#print("%s says hi to %s %d times" % ["James", "Sarah", 5])
	
#	print(df.GetRow(2))
#	print(df.GetColumn("Team"))
