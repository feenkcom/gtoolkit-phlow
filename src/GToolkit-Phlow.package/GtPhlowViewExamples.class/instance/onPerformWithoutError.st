secure execution
onPerformWithoutError
	<gtExample>
	| aView |
	aView := GtPhlowExplicitView on: self perform: #gtViewsFor:.
	self assert: aView class equals: GtPhlowLabelledView.
	self assert: aView originalView originalView class equals: GtPhlowExplicitView.
	^ aView