accessing
asElementDo: aBlock
	| element |
	element := stencilBuilder build.
	^ aBlock value: element