Class {
	#name : #GtPhlowColumnContext,
	#superclass : #Object,
	#instVars : [
		'rowItem',
		'rowIndex',
		'columnIndex',
		'theme'
	],
	#category : 'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowColumnContext >> columnIndex [
	<return: #Integer>
	^ columnIndex
]

{ #category : #accessing }
GtPhlowColumnContext >> columnIndex: anInteger [
	columnIndex := anInteger
]

{ #category : #accessing }
GtPhlowColumnContext >> rowIndex [
	<return: #Integer>
	^ rowIndex
]

{ #category : #accessing }
GtPhlowColumnContext >> rowIndex: anInteger [
	rowIndex := anInteger
]

{ #category : #accessing }
GtPhlowColumnContext >> rowItem [
	^ rowItem
]

{ #category : #accessing }
GtPhlowColumnContext >> rowItem: anObject [
	rowItem := anObject
]

{ #category : #accessing }
GtPhlowColumnContext >> theme [
	"I can be used to access theme colors, etc."

	<return: #BlTheme>
	^ theme
]

{ #category : #accessing }
GtPhlowColumnContext >> theme: aBlTheme [
	theme := aBlTheme
]
