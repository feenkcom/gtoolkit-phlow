Class {
	#name : #GtPhlowListHandler,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #initialization }
GtPhlowListHandler >> initialize [
	super initialize.
	transformation := [ :x : indices | "by default there is no transformation" x ]
]

{ #category : #accessing }
GtPhlowListHandler >> transformation [
	^ transformation
]

{ #category : #accessing }
GtPhlowListHandler >> transformation: anObject [	
	transformation := anObject
]

{ #category : #accessing }
GtPhlowListHandler >> transformedValueFrom: anObject selection: aSelectionIndices [
	^ self transformation cull: anObject cull: aSelectionIndices
]
