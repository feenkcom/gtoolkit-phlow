"
Ordered cell decorations. The first is closest to the content; later decorations wrap earlier ones.
"
Class {
	#name : #GtPhlowColumnDecorations,
	#superclass : #Object,
	#instVars : [
		'decorations'
	],
	#category : #'GToolkit-Phlow-Support - Decorations'
}

{ #category : #accessing }
GtPhlowColumnDecorations >> add: aDecoration [
	decorations add: aDecoration.
	^ aDecoration
]

{ #category : #scripting }
GtPhlowColumnDecorations >> border [
	^ self add: GtPhlowColumnBorderDecoration new
]

{ #category : #initialization }
GtPhlowColumnDecorations >> initialize [
	super initialize.
	decorations := OrderedCollection new
]

{ #category : #testing }
GtPhlowColumnDecorations >> isEmpty [
	^ decorations isEmpty
]

{ #category : #accessing }
GtPhlowColumnDecorations >> items [
	^ decorations copy
]

{ #category : #scripting }
GtPhlowColumnDecorations >> normalizedBar [
	^ self add: GtPhlowColumnNormalizedBarDecoration new
]

{ #category : #updating }
GtPhlowColumnDecorations >> prepareForUpdateContent [
	decorations do: #prepareForUpdateContent
]

{ #category : #building }
GtPhlowColumnDecorations >> wrap: anElement [
	^ decorations inject: anElement into: [ :element :decoration | decoration wrap: element ]
]
