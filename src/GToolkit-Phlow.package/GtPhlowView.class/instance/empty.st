transforming
empty
	^ GtPhlowEmptyView new
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition