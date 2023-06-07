Extension { #name : #Symbol }

{ #category : #'*GToolkit-Phlow' }
Symbol >> asPhlowSendTransformation [
	^ GtPhlowSendTransformation object: [ :obj | self value: obj ]
]

{ #category : #'*GToolkit-Phlow' }
Symbol >> phlowValue: aReceiver withEnoughArguments: aCollection [
	^ aReceiver perform: self withEnoughArguments: aCollection
]
