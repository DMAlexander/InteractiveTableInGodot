extends Control

@onready var rows: VBoxContainer = $Rows
@onready var row_highlight: ColorRect = $RowHighlight
@onready var column_highlight: ColorRect = $ColumnHighlight

@onready var TableRow = preload("res://table_row.tscn")
@onready var TableCell = preload("res://table_cell.tscn")
@onready var TableHeaderCell = preload("res://table_header_cell.tscn")

@export var data: DataFrame

var sorted_desc: bool = false
var cell_size: Vector2i = Vector2i.ZERO

func _process(delta):
	var mouse_pos = get_local_mouse_position()
	if Rect2(Vector2.ZERO, size).has_point(mouse_pos):
		var mouse_snapped = (mouse_pos - 0.5 * cell_size).snapped(cell_size)
		
		row_highlight.position.y = mouse_snapped.y
		column_highlight.position.x = mouse_snapped.x

func Render():
	
	for n in rows.get_children():
		n.queue_free()
	
	if data:
		var row_count = data.Size()
		
		var cols_row = TableRow.instantiate()
		rows.add_child(cols_row)
		
		for col in data.columns:
			var cell = TableHeaderCell.instantiate()
			cell.text = col
			cols_row.add_child(cell)
			
			cell.pressed.connect(_on_header_clicked.bind(col))
		
		for r in range(row_count):
			var row = TableRow.instantiate()
			rows.add_child(row)
			
			for value in data.GetRow(r):
				var cell = TableCell.instantiate()
				cell.text = str(value)
				row.add_child(cell)
		
		
		var col_size = size.y / (row_count + 1)
		var row_size = size.x / (len(data.columns))
		cell_size = Vector2i(row_size, col_size)
		
		row_highlight.size.y = col_size
		column_highlight.size.x = row_size
				
func _on_header_clicked(col: String):
	print("Column clicked: ", col)
	
	data.SortBy(col, sorted_desc)
	sorted_desc = !sorted_desc
	Render()
