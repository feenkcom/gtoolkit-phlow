Trait {
	#name : #TGtPhlowToolAccessors,
	#instVars : [
		'tool'
	],
	#category : #'GToolkit-Phlow-Events'
}

{ #category : #defaults }
TGtPhlowToolAccessors >> defaultTool [
	^ GtPhlowTool default
]

{ #category : #initialization }
TGtPhlowToolAccessors >> initializeTool [
	tool := self defaultTool
]

{ #category : #accessing }
TGtPhlowToolAccessors >> tool [
	<return: #GtPhlowTool>
	^ tool
]

{ #category : #accessing }
TGtPhlowToolAccessors >> tool: aGtPhlowTool [
	self 
		assert: [ aGtPhlowTool isNotNil ]
		description: [ 'Phlow tool must be non-nil' ].
	tool := aGtPhlowTool
]
