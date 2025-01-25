Extension { #name : #BrTextStreamExamples }

{ #category : #'*GToolkit-Phlow-Examples' }
BrTextStreamExamples >> elaborateTextAndAdornment [
	<gtExample>
	| stream expanderAttribute |
	stream := BlTextStream new.
	stream next
		putAll: 'We can now';
		cr;
		fontSize: 30;
		foreground: Color blue;
		putAll: 'create text'.
	stream next
		cr;
		bold;
		putAll: 'through a'.
	stream next space
		putAll: 'flexible';
		cr;
		fontSize: 30;
		glamorousCodeFont;
		medium;
		putAll: 'streaming interface'.
	stream next
		put: $.;
		cr;
		expanded: true
			adornment: [ (stream contents asString gtViewsFor: GtPhlowView empty)
					asElementDo: [ :e | 
						e
							addAptitude: BrShadowAptitude new;
							background: Color white;
							constraintsDo: [ :c | c vertical exact: 300 ] ] ];
		highlight: Color paleYellow;
		putAll: 'Including fancy artifacts'.
	expanderAttribute := (stream contents attributesAt: stream contents size)
			detect: [ :each | each class = BrGlamorousTriangleExpanderTextAttribute ].
	self assert: expanderAttribute notNil.
	self assert: expanderAttribute isExpanded.
	^ stream
]
