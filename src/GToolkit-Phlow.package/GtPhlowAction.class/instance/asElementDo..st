accessing
asElementDo: aBlock
	| element |
	element := [ stencilBuilder asElement ] 
		on: Error 
		do: [:error | 
			error freeze.
			GtPhlowViewWithError new error: error; asElementDo: [ :errorElement | errorElement ] ].
	^ aBlock value: element.