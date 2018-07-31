as yet unclassified
labelledCompositeView
	<gtExample>
	| view element |
	view := self compositeView labelled label: 'Composite'.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	self assert: (element children first isKindOf: BlTextElement).
	^ view