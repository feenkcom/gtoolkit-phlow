Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Phlow' }
BlockClosure >> asPhlowSendTransformation [
	^ GtPhlowSendToolTransformation object: self
]
