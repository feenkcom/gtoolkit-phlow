Extension { #name : #BlElement }

{ #category : #'*GToolkit-Phlow' }
BlElement >> phlow [
	^ self userData
		at: #phlow 
		ifAbsentPut: [ GtPhlowElementContext on: self ]
]

{ #category : #'*GToolkit-Phlow' }
BlElement >> transmit [
	^ GtPhlowTransmission new root: self
]
