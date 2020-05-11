Class {
	#name : #GtPhlowViewBuilder,
	#superclass : #GtPhlowViewProtoBuilder,
	#traits : 'TGtPhlowViewAccessor + TGtPhlowContextAccessor',
	#classTraits : 'TGtPhlowViewAccessor classTrait + TGtPhlowContextAccessor classTrait',
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #initialization }
GtPhlowViewBuilder >> initialize [
	super initialize.
	self initializePhlowContext.
	self initializePhlowView.
]

{ #category : #accessing }
GtPhlowViewBuilder >> object [
	^ object
]

{ #category : #accessing }
GtPhlowViewBuilder >> object: anObject [
	"Set an object for which a view will be built"
	object := anObject
]
