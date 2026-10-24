"
A composable border around cell content.
"
Class {
	#name : #GtPhlowColumnBorderDecoration,
	#superclass : #GtPhlowColumnDecoration,
	#instVars : [
		'color',
		'width'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #binding }
GtPhlowColumnBorderDecoration >> bind: anElement value: aValue rowIndex: aRowIndex columnIndex: aColumnIndex [
	anElement border: (BlBorder paint: (color ifNil: [ Color gray ]) width: (width ifNil: [ 1 ]))
]

{ #category : #scripting }
GtPhlowColumnBorderDecoration >> color: aColor [
	color := aColor
]

{ #category : #scripting }
GtPhlowColumnBorderDecoration >> width: aNumber [
	width := aNumber
]
