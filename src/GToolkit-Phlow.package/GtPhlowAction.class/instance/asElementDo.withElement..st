accessing
asElementDo: aBlock withElement: aTargetElement
	| element |
	element := [ stencilBuilder targetElement: aTargetElement. stencilBuilder asElement  ] 
		on: Error 
		do: [:error | 
			error freeze.
			GtPhlowActionWithError new error: error; asElementDo: [ :errorElement | errorElement ] withElement: aTargetElement ].
	^ aBlock value: element.