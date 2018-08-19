transforming
composite
	^ GtPhlowCompositeView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition