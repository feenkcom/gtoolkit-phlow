Extension { #name : #RGMethodDefinition }

{ #category : #'*GToolkit-Phlow' }
RGMethodDefinition >> gtOriginMethodsInto: aWriteStream [ 
	aWriteStream nextPut: self
]

{ #category : #'*GToolkit-Phlow' }
RGMethodDefinition >> gtPhlowIncludesCompiledMethod: aCompiledMethod [
	^ self = aCompiledMethod asRingDefinition
]
