secure execution
onPerformWithErrorBlocElement
	<gtExample>
	| aView anElement |
	aView := self onPerformWithError.
	anElement := aView asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	^ anElement