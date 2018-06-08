accessing
asElementDo: aBlock
	| element |
	element := [ stencilBuilder build asElement] 
		on: Error 
		do: [:error | 
			error freeze.
			GtPhlowViewWithError new error: error; asElementDo: [ :errorElement | errorElement ] ].
	^ aBlock value: element.