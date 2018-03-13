scripting
andShow: aBlock
	self strategy: GtPhlowTransmissionReplaceAndShowStrategy new.
	self halt.
	self fromElement when: self announcementRegistration do: [ :ann | 
		self toElement removeChildren.
		self toElement addChildren: (aBlock value: ann) asOrderedCollection ]