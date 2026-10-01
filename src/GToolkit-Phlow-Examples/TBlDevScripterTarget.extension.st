Extension { #name : #TBlDevScripterTarget }

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterTarget >> onMultipleViewsToolElement [
	self // GtPhlowMultipleViewsContentElement
]

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterTarget >> onPhlowCellWithString: aString index: anIndex [
	self
		// GtPhlowCellElement;
		@ [ :aPhlowCell | aPhlowCell content text asString = aString ];
		@ anIndex
]

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterTarget >> onPhlowToolEntity [
	self 
		onChildFromBlock: [ :anElement | anElement phlow entity ]
]
