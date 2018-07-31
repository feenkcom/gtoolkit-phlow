as yet unclassified
compositeView
	<gtExample>
	| view element |
	view := GtPhlowExplicitView new composite views: {self explicitViewWithElementStencil}.
	view asElementDo: [ :el | element := el ].
	self assert: (element isKindOf: BrTabGroup).
	^ view