Extension { #name : #GtPagerContext }

{ #category : #'*GToolkit-Phlow' }
GtPagerContext >> toolSelectionStatesHandler [
	<return: #GtPhlowToolSelectionStateHandler>
	
	^ self 
		optionAt:  #toolSelectionStatesHandler 
		ifAbsentPut: [ GtPhlowToolSelectionStateHandler new ]
]
