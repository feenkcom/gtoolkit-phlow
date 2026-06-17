Trait {
	#name : #TGtElementAssertion,
	#category : #'GToolkit-Phlow-Traits'
}

{ #category : #asserting }
TGtElementAssertion >> assertElement: anElement [
	self 
		assert: [ anElement isNotNil ]
		description: [ 'Content element must be non-nil' ].
	self 
		assert: [ anElement isKindOf: BlElement ]
		description: [ 'Content element must be kind of ', BlElement name ].
]
