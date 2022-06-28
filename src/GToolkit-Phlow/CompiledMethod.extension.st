Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Phlow' }
CompiledMethod >> phlowValue: anObject withEnoughArguments: aCollection [

	^ anObject withArgs: aCollection executeMethod: self
]
