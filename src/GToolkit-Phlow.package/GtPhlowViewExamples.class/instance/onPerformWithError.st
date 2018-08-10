secure execution
onPerformWithError
	<gtExample>
	| aView |
	aView := GtPhlowExplicitView on: nil perform: #nonExistingMethod:.
	self assert: aView class equals: GtPhlowViewWithError.
	^ aView