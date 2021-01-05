Trait {
	#name : #TGtPhlowContextAccessor,
	#instVars : [
		'context'
	],
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #accessing }
TGtPhlowContextAccessor >> context [
	<return: #GtPhlowContext>
	^ context
]

{ #category : #accessing }
TGtPhlowContextAccessor >> context: aGtPhlowContext [
	self 
		assert: [ aGtPhlowContext isNotNil ]
		description: [ 'Phlow context must be non-nil' ].
	context := aGtPhlowContext
]

{ #category : #defaults }
TGtPhlowContextAccessor >> defaultPhlowContext [
	^ GtPhlowContext new
]

{ #category : #initialization }
TGtPhlowContextAccessor >> initializePhlowContext [
	context := self defaultPhlowContext.
]
