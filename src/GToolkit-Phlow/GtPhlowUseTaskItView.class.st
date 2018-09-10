Class {
	#name : #GtPhlowUseTaskItView,
	#superclass : #DynamicVariable,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
GtPhlowUseTaskItView class >> enabled [
	"Answer if converting to TaskIt is enabled.
	The default is true."
	
	^ self value
		ifNil: [ true ]
		ifNotNil: [ :value | value ]
]
