private
errorExample
	<gtExample>
	| debugButton |
	debugButton := self gtActions last asElementDo: [ :x | x ].
	self assert: (debugButton isKindOf: BrButton).
	^ debugButton 