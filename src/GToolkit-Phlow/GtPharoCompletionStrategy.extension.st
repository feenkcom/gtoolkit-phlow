Extension { #name : #GtPharoCompletionStrategy }

{ #category : #'*GToolkit-Phlow' }
GtPharoCompletionStrategy >> gtViewArgumentType: aNode [
	<gtVariableType>
	^ ((aNode pragmasNamed: #gtView) notEmpty
		and: [ aNode = aNode topParent variables first ])
		ifTrue: [ ^ GtPhlowProtoView ]
]
