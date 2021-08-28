"
I am used by some concrete ${class:GtPhlowView}$ subclasses, see ${class:TGtPhlowSendTransformable|label=my users|show=#gtUsersFor:|height=150|expanded}$:
I extend those classes with:
- ${method:TGtPhlowSendTransformable>>#send:|label=#selector}$, and
- ${method:TGtPhlowSendTransformable>>#sendTool:|label=#selector}$.
!! Send Example
In the following example, when the list items are selected (double click), ${example:GtPhlowListViewExamples>>#sendNumberAddition|label}$ is added to selected items that are displayed in the next pane: ${example:GtPhlowListViewExamples>>#sendObject_Block|codeExpanded=false|previewExpanded=true}$
!! Send Tool Example
In the following example, when the list items are selected (double click), a ${class:GtPhlowTool|label=Phlow tool}$ is used to display selected items in the next pane: ${example:GtPhlowListViewExamples>>#sendTool|codeExpanded=false|previewExpanded=true}$
In this case, it is a  ${class:BlElement}$ widget that displays selected numbers in the middle. More elaborate and dedicated Phlow tools can be used, see ${class:GtPhlowTool|expanded|show=#gtSubclassesFor:}$ subclasses:
"
Trait {
	#name : 'TGtPhlowSendTransformable',
	#instVars : [
		'transformation'
	],
	#category : 'GToolkit-Phlow-Support - Transformation'
}

{ #category : 'private - asserting' }
TGtPhlowSendTransformable >> assertTransformation: aGtPhlowSendTransformation [
	self 
		assert: [ aGtPhlowSendTransformation respondsTo: #asPhlowSendTransformation ] 
		description: [ self className, '''s transformation must understand the ', 
			#asPhlowSendTransformation asString, ' method' ]
]

{ #category : 'defaults' }
TGtPhlowSendTransformable >> defaultTransformation [
	^ GtPhlowSendTransformation default
]

{ #category : 'private - testing' }
TGtPhlowSendTransformable >> hasTransformation [
	<return: #Boolean>
	^ transformation isNotNil
]

{ #category : 'private - accessing' }
TGtPhlowSendTransformable >> send [
	<return: #GtPhlowSendTransformation>
	self 
		deprecated: 'use #transformation '
		transformWith: '`@receiver send' -> '`@receiver transformation'.
	^ self transformation
]

{ #category : 'api - scripting' }
TGtPhlowSendTransformable >> send: aBlock [
	"Define what object should be displayed on selection and fire select or spawn item requests"
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

{ #category : 'api - scripting' }
TGtPhlowSendTransformable >> sendTool: aBlock [
	"Define what tool should be displayed on selection and send select or spawn tool requests"
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

{ #category : 'private - accessing' }
TGtPhlowSendTransformable >> transformation [
	<return: #GtPhlowSendTransformation>
	^ transformation ifNil: [ self defaultTransformation ]
]

{ #category : 'private - accessing' }
TGtPhlowSendTransformable >> transformation: aGtPhlowSendTransformation [
	self assertTransformation: aGtPhlowSendTransformation.
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation.
]
