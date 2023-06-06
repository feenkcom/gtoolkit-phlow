Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Phlow' }
CompiledMethod >> phlowValue: aReceiver withEnoughArguments: aCollection [
	^ aReceiver withArgs: aCollection executeMethod: self
]
