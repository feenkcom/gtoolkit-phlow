Trait {
	#name : #TGtPhlowViewSelectorAssertion,
	#category : 'GToolkit-Phlow-Collectors'
}

{ #category : #asserting }
TGtPhlowViewSelectorAssertion >> assertViewSelector: aSymbol [
	self 
		assert: [ aSymbol isSymbol ] 
		description: [ 'View message selector must a symbol' ].
	self 
		assert: [ aSymbol size isZero not ] 
		description: [ 'View message selector must a non-empty symbol' ].
	self 
		assert: [ aSymbol numArgs = 1 or: [ aSymbol numArgs = 2 ] ] 
		description: [ 'View message selector must have one or two arguments' ].

]
