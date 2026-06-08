Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterActionStep >> multipleViewsToolStep [
	<scripterActionStep>
	
	^ self
		addStep: (GtPhlowMultipleViewsToolStep new
				label: 'Multiple Views Tool';
				referenceSender;
				onParentStepTarget: self)
]

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterActionStep >> phlowCompositeToolStep [
	<scripterActionStep>
	
	^ self
		addStep: (GtPhlowCompositeToolStep new
				label: 'Phlow Composite Tool';
				referenceSender;
				onParentStepTarget: self)
]
