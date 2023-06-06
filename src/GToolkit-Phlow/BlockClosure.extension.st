Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Phlow' }
BlockClosure >> asPhlowSendTransformation [
	^ GtPhlowSendToolTransformation object: self
]

{ #category : #'*GToolkit-Phlow' }
BlockClosure >> phlowValue: aReceiver withEnoughArguments: anArray [
	"Execute this block closure with enough arguments from aReceiver + anArray.
	Please note, that aReceiver is passed as a first argument followed by all values from anArray."
	| args |

	self numArgs isZero
		ifTrue: [ ^ self value ].

	self numArgs = 1
		ifTrue: [ ^ self value: aReceiver ].

	self numArgs <= (anArray size + 1)
		ifFalse: [ self numArgsError: anArray size + 1 ].

	self numArgs = 2
		ifTrue: [ ^ self value: aReceiver value: anArray first ].

	self numArgs = 3
		ifTrue: [ ^ self value: aReceiver value: anArray first value: anArray second ].

	self numArgs = 4
		ifTrue: [ ^ self value: aReceiver value: anArray first value: anArray second value: anArray third ].

	args := Array new: self numArgs.
	args at: 1 put: aReceiver.
	args replaceFrom: 2
		to: ((anArray size + 1) min: args size)
		with: anArray
		startingAt: 1.

	^ self valueWithArguments: args
]
