"
I am used by some concrete {{gtClass:GtPhlowView}} subclasses, see {{gtClass:TGtPhlowSendTransformable|label=my users|show=#gtUsersFor:|height=150|expanded}}:
I extend those classes with:
- {{gtMethod:TGtPhlowSendTransformable>>#send:|label=#selector}}, and
- {{gtMethod:TGtPhlowSendTransformable>>#sendTool:|label=#selector}}.
## Send Example
In the following example, when the list items are selected (double click), {{gtExample:GtPhlowListViewExamples>>#sendNumberAddition|label}} is added to selected items that are displayed in the next pane: {{gtExample:GtPhlowListViewExamples>>#sendObject_Block|codeExpanded=false|previewExpanded=true}}
## Send Tool Example
In the following example, when the list items are selected (double click), a {{gtClass:GtPhlowTool|label=Phlow tool}} is used to display selected items in the next pane: {{gtExample:GtPhlowListViewExamples>>#sendTool|codeExpanded=false|previewExpanded=true}}
In this case, it is a  {{gtClass:BlElement}} widget that displays selected numbers in the middle. More elaborate and dedicated Phlow tools can be used, see {{gtClass:GtPhlowTool|expanded|show=#gtSubclassesFor:}} subclasses:

"
Trait {
	#name : #TGtPhlowSendTransformable,
	#instVars : [
		'transformation'
	],
	#category : #'GToolkit-Phlow-Support - Transformation'
}

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
TGtPhlowSendTransformable >> send: aBlockOrSymbolOrTransformation [
	"Define what object should be displayed on selection and fire select or spawn item requests"
	self
		assert: [ aBlockOrSymbolOrTransformation isNotNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	self transformation: aBlockOrSymbolOrTransformation asPhlowSendTransformation
]

{ #category : #'api - scripting' }
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

{ #category : #'private - accessing' }
TGtPhlowSendTransformable >> transformation [
	<return: #GtPhlowSendTransformation>
	^ transformation ifNil: [ self defaultTransformation ]
]

{ #category : #'private - accessing' }
TGtPhlowSendTransformable >> transformation: aGtPhlowSendTransformation [
	transformation := aGtPhlowSendTransformation asPhlowSendTransformation.
]
