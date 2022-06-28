Extension { #name : #Symbol }

{ #category : #'*GToolkit-Phlow' }
Symbol >> asPhlowSendTransformation [
	^ GtPhlowSendTransformation object: [ :obj | self value: obj ]
]

{ #category : #'*GToolkit-Phlow' }
Symbol >> phlowValue: anObject withEnoughArguments: aCollection [

	^ anObject perform: self withEnoughArguments: aCollection
]
