Extension { #name : #WrapperSignal }

{ #category : #'*GToolkit-Phlow' }
WrapperSignal >> gtDefaultInspectorTool [
	^ GtPhlowCompositeTool new
		addTool: (super gtDefaultInspectorTool);
		addTool: (self target gtDefaultInspectorTool
			name: 'Target')
]
