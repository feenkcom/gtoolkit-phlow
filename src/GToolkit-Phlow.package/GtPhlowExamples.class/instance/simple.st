public
simple
	<gtExample>
	| pane1 picker root pane2 |
	root := GtPhlowRoot new.
	root layout: BlFlowLayout vertical.
	pane1 := BlElement new.
	pane1 background: Color yellow; border: (BlBorder paint: Color black).
	pane1 size: 100 @ 100.
	picker := GtDiagrammerNumberPicker new.
	picker select: 2.
	picker display: [ 1 to: 3 ].
	picker constraintsDo: [ :c | 
		c horizontal fitContent.
		c vertical fitContent ].
	picker
		when: BrToggleActivatedEvent
		do: [ :anEvent | (root childNamed: #pane1) fireEvent: anEvent ].
	pane1 addChild: picker.
	pane2 := BlElement new background: Color blue.
	pane2 size: 100 @ 100.
	root addChild: pane1 as: #pane1.
	root addChild: pane2 as: #pane2.
	root size: 300 @ 300.
	root transmit 
		when: BrToggleActivatedEvent
		from: #pane1;
		to: #pane2;
		andShow: [ :ann | BlElement new background: Color red ].
	^ root 