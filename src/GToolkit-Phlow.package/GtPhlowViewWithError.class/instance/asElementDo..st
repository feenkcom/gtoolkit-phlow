accessing
asElementDo: aBlock
	| container textElement text debugButton |
	text := error printString asRopedText.
	text foreground: Color red.
	container := BlElement new.
	textElement := BlTextElement new text: text.
	textElement constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	container layout: BlLinearLayout vertical.
	container addChild: textElement.
	debugButton := BrButton new.
	debugButton look: BrMaterialToggleIconifiedLook 
		+ BrMaterialToggleLabelledLook.
	debugButton label: 'Debug'.
	debugButton action: [ [error defaultAction] fork ].
	container addChild: debugButton.
	container constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	^ aBlock value: container