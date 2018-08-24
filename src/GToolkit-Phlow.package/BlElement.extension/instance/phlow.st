*GToolkit-Phlow
phlow
	^ self userData
		at: #phlow 
		ifAbsentPut: [ GtPhlowElement on: self ]