Class {
	#name : #GtPhlowThemeIconNameColumn,
	#superclass : #GtPhlowIconNameColumn,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - building' }
GtPhlowThemeIconNameColumn >> createIconElementFromName: anIconName [ 
	^ (Smalltalk ui icons 
		iconNamed: anIconName) asElement
]
