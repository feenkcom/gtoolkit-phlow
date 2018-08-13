examples
explicitViewWithElementStencil
	<gtExample>
	| view element |
	view := GtPhlowExplicitView new 
		title: 'Sample';
		stencil: [ BlElement new ].
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BlElement).
	^ view