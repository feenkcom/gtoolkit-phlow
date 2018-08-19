transforming
labelled
	^ GtPhlowLabelledView new 
		originalView: self;
		definingMethod: thisContext stack second method asRingDefinition