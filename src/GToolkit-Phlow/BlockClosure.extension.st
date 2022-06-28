Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Phlow' }
BlockClosure >> asPhlowSendTransformation [
	^ GtPhlowSendToolTransformation object: self
]

{ #category : #'*GToolkit-Phlow' }
BlockClosure >> phlowValue: anObject withEnoughArguments: aCollection [

	^ self valueWithEnoughArguments:  aCollection
]
