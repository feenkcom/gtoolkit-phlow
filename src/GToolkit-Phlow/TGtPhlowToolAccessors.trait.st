Trait {
	#name : #TGtPhlowToolAccessors,
	#instVars : [
		'tool'
	],
	#category : #'GToolkit-Phlow-Tool - Support'
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
TGtPhlowToolAccessors >> object [
	^ self tool object
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
