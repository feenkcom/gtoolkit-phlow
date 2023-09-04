Class {
	#name : #GtPhlowThemeIconNameColumn,
	#superclass : #GtPhlowIconNameColumn,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #testing }
GtPhlowThemeIconNameColumn class >> isAbstract [
	^ self name = #GtPhlowThemeIconNameColumn
]

{ #category : #'api - building' }
GtPhlowThemeIconNameColumn >> createIconElementFromName: anIconName [ 
	^ (Smalltalk ui icons 
		iconNamed: anIconName) asElement
]
