Extension { #name : #TBlDevScripterTarget }

{ #category : #'*GToolkit-Phlow-Examples' }
TBlDevScripterTarget >> onPhlowToolEntity [
	self 
		onChildFromBlock: [ :anElement | anElement phlow entity ]
]
