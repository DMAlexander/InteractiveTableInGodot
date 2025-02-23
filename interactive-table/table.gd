extends Control

@onready var rows: VBoxContainer = $Rows

@onready var TableRow = preload("res://table_row.tscn")
@onready var TableCell = preload("res://table_cell.tscn")
@onready var TableHeaderCell = preload("res://table_header_cell.tscn")

@export var data: DataFrame


func Render():
	
	if data:
		var row_count = data.Size()
		
		var cols_row = TableRow.instantiate()
		rows.add_child(cols_row)
		
		for col in data.columns:
			var cell = TableHeaderCell.instantiate()
			cell.text = col
			cols_row.add_child(cell)
		
		for r in range(row_count):
			var row = TableRow.instantiate()
			rows.add_child(row)
			
			for value in data.GetRow(r):
				var cell = TableCell.instantiate()
				cell.text = str(value)
				row.add_child(cell)
