Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterActionStep >> phlowCompositeTool [
	^ self
		addStep: (GtPhlowCompositeToolStep new
				referenceSender;
				onParentStepTarget: self)
]
