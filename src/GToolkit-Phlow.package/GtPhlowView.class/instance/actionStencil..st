accessing
actionStencil: anActionStencil
	| newPhlowAction |
	newPhlowAction := GtPhlowAction new.
	newPhlowAction stencil: anActionStencil.
	phlowActions add: newPhlowAction.