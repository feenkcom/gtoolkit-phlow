Trait {
	#name : #TGtPhlowSendTransformable,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Support - Transformation'
}

{ #category : #'private - asserting' }
TGtPhlowSendTransformable >> assertTransformation: aGtPhlowSendTransformation [
	self 
		assert: [ aGtPhlowSendTransformation isKindOf: GtPhlowSendTransformation ] 
		description: [ self className, '''s transformation must be a ', GtPhlowSendTransformation name, ' object' ]
]

{ #category : #defaults }
TGtPhlowSendTransformable >> defaultTransformation [
	^ GtPhlowSendTransformation default
]

{ #category : #'private - testing' }
TGtPhlowSendTransformable >> hasTransformation [
	<return: #Boolean>
	^ transformation isNotNil
]

{ #category : #'private - accessing' }
TGtPhlowSendTransformable >> send [
	<return: #GtPhlowSendTransformation>
	self 
		deprecated: 'use #transformation '
		transformWith: '`@receiver send' -> '`@receiver transformation'.
	^ self transformation
]

{ #category : #'api - scripting' }
TGtPhlowSendTransformable >> send: aBlock [
	"Define what object should be displayed on selection and fire select or spawn item request"
	self
		assert: [ aBlock isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		self transformation: (GtPhlowSendTransformation object: [ :obj | aBlock value: obj ]).
		^ self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	self transformation: (GtPhlowSendTransformation object: aBlock)
]

{ #category : #'api - scripting' }
TGtPhlowSendTransformable >> sendTool: aBlock [
	"Define what tool should be displayed on selection and send select or spawn tool request"
	self
		assert: [ aBlock isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		self transformation: (GtPhlowSendTransformation tool: [ :obj | aBlock value: obj ]).
		^ self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	self transformation: (GtPhlowSendTransformation tool: aBlock).
]

{ #category : #'private - accessing' }
TGtPhlowSendTransformable >> transformation [
	<return: #GtPhlowSendTransformation>
	^ transformation ifNil: [ self defaultTransformation ]
]

{ #category : #'private - accessing' }
TGtPhlowSendTransformable >> transformation: aGtPhlowSendTransformation [
	self assertTransformation: aGtPhlowSendTransformation.
	transformation := aGtPhlowSendTransformation.
]
