scripting
andShow: aBlock
	self strategy: GtPhlowTransmissionReplaceAndShowStrategy new.
	self fromElement when: self announcementRegistration do: [ :ann | 
		self toElement removeChildren.
		self toElement addChildren: (aBlock value: ann) asOrderedCollection ]