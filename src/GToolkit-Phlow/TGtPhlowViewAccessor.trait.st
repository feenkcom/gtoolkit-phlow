Trait {
	#name : #TGtPhlowViewAccessor,
	#instVars : [
		'view'
	],
	#category : #'GToolkit-Phlow-! Views and Actions'
}

{ #category : #defaults }
TGtPhlowViewAccessor >> defaultPhlowView [
	^ GtPhlowView empty 
]

{ #category : #initialization }
TGtPhlowViewAccessor >> initializePhlowView [
	view := self defaultPhlowView
]

{ #category : #accessing }
TGtPhlowViewAccessor >> view [
	<return: #GtPhlowView>
	^ view
]

{ #category : #accessing }
TGtPhlowViewAccessor >> view: aGtPhlowView [
	self 
		assert: [ aGtPhlowView isNotNil ]
		description: [ 'Phlow view must be non-nil' ].
	view := aGtPhlowView
]
