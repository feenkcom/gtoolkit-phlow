Class {
	#name : 'GtPhlowExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Phlow-Examples'
}

{ #category : 'public' }
GtPhlowExamples >> simple [
	<gtExample>
	| pane1 picker root pane2 |
	root := BlElement new.
	root layout: BlFlowLayout vertical.
	pane1 := BlElement new
		border: (BlBorder paint: Color gray);
		size: 100 @ 100.
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
	pane2 := BlElement new
		border: (BlBorder paint: Color gray);
		size: 100 @ 100.
	root addChild: pane1 as: #pane1.
	root addChild: pane2 as: #pane2.
	root size: 300 @ 300.
	root transmit 
		when: BrToggleActivatedEvent
		from: #pane1;
		to: #pane2;
		andShow: [ :ann | BlTextElement new text: ann source model asString asRopedText ].
	^ root 
]
