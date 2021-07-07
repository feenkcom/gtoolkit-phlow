Extension { #name : #Context }

{ #category : #'*GToolkit-Phlow' }
Context >> gtPhlowDefiningMethod [
	"Return a CompiledMethod this context belongs to"
	| anOuterMostContext aCompiledCode |
	
	anOuterMostContext := self outerMostContext.
	
	"In Pharo9 Context>>#method was renamed to Context>>#compiledCode because it can return CompiledBlock, not just CompiledMethod"
	aCompiledCode := (anOuterMostContext respondsTo: #compiledCode)
		ifTrue: [ anOuterMostContext compiledCode ]
		ifFalse: [ anOuterMostContext method ].
		
	^ aCompiledCode isCompiledMethod
		ifTrue: [ aCompiledCode ]
		ifFalse: [ anOuterMostContext gtPhlowDefiningMethod ]
]

{ #category : #'*GToolkit-Phlow' }
Context >> gtPhlowMethodDefinition [
	"Return a Ring method definition for the CompiledMethod this context belongs to"

	^ self gtPhlowDefiningMethod asRingDefinition
]
