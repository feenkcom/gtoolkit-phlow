Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Phlow' }
CompiledMethod >> gtPhlowIncludesCompiledMethod: aCompiledMethod [
	"We rely on this is case the source source of an extension is a doit"
	^ self = aCompiledMethod
]

{ #category : #'*GToolkit-Phlow' }
CompiledMethod >> phlowValue: aReceiver withEnoughArguments: aCollection [
	^ aReceiver withArgs: aCollection executeMethod: self
]
