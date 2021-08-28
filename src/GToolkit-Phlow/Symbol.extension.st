Extension { #name : 'Symbol' }

{ #category : '*GToolkit-Phlow' }
Symbol >> asPhlowSendTransformation [
	^ GtPhlowSendTransformation object: [ :obj | self value: obj ]
]
