accessing
asElementDo: aBlock
	| container labelElement |
	container := BlElement new.
	container layout: BlLinearLayout vertical.
	container constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	labelElement := BlTextElement new text: self label asRopedText.
	labelElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	container addChild: labelElement.
	self originalView asElementDo: [ :originalElement | 
		container addChild: originalElement ].
	^ aBlock value: container