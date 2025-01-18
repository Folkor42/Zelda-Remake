class_name Puzzle extends Node2D

signal cleared

func completed()->void:
	print ("Puzzle Solved")
	cleared.emit()
