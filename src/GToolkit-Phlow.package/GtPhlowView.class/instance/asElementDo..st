accessing
asElementDo: aBlock
	| element |
	element := stencilBuilder build asElement.
	^ aBlock value: element