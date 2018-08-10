examples
emptyExplicitView
	<gtExample>
	| view element |
	view := self explicitViewWithElementStencil empty.
	view asElementDo: [ :el | element := el ].
	self assert: element isNil.
	^ view