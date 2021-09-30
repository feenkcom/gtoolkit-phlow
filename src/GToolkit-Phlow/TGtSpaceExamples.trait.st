Trait {
	#name : #TGtSpaceExamples,
	#category : 'GToolkit-Phlow-Examples - Views'
}

{ #category : #'examples - support' }
TGtSpaceExamples >> newSpace [
	"By using ${class:BlMockedHost}$, we need to explicitly perform ${method:BlSpace>>pulse}$ 
	whenever a enqueued task should be processed."
	<gtExample>
	| aSpace |
	aSpace := BlSpace new.
	aSpace host: BlMockedHost new.
	aSpace title: 'Async Element Examples'.
	aSpace extent: 600@400.
	aSpace withHalos.
	^ aSpace
]

{ #category : #'examples - support' }
TGtSpaceExamples >> performUIAction: aBlock in: anElement [
	self
		assert: [ anElement isAttachedToSceneGraph ]
		description: [ anElement asString, ' must be attached to a scene graph in order to perform enqueued tasks' ].
	anElement enqueueTask: (BlTaskAction new action: aBlock).
	anElement space pulse.
]

{ #category : #'examples - support' }
TGtSpaceExamples >> putInSpace: aBlElement [
	<gtExample>
	| aSpace |
	self 
		assert: [ aBlElement isNotNil ]
		description: [ 'Element must be non-nil' ].
	aSpace := self newSpace.
	aSpace enqueueTask: (BlTaskAction new action: [ 
		aSpace root addChild: aBlElement ]).
	aSpace pulse.
	^ aSpace
]
