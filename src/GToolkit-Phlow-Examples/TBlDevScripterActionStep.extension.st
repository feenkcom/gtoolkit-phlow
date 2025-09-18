Extension { #name : #TBlDevScripterActionStep }

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterActionStep >> phlowCompositeToolStep [
	^ self
		addStep: (GtPhlowCompositeToolStep new
				label: 'Phlow Composite Tool';
				referenceSender;
				onParentStepTarget: self)
]
