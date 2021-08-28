"
I add a scripting method to display items as a text.
I am used by ${class:GtPhlowListView}$ and ${class:GtPhlowTreeView}$.

"
Trait {
	#name : 'TGtPhlowItemText',
	#instVars : [
		'itemTextBlock'
	],
	#category : 'GToolkit-Phlow-Support'
}

{ #category : 'api - scripting' }
TGtPhlowItemText >> itemDataBinder: aBrTreeNodeDataBinderOrBlock [
	self explicitRequirement
]

{ #category : 'api - scripting' }
TGtPhlowItemText >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	self explicitRequirement
]

{ #category : 'accessing' }
TGtPhlowItemText >> itemText [ 
	"Answer the BlockClosure / Symbol used to transform the item to the text to be displayed.
	This is kept for purposes like the remote object inspection where the text is desired, not the BlElement displaying the text."
	<return: #BlockClosure>

	^ itemTextBlock
]

{ #category : 'api - scripting' }
TGtPhlowItemText >> itemText: aBlockOrSymbol [

	itemTextBlock := aBlockOrSymbol.
	self itemStencil: [ self newItemLabel ].
	self itemDataBinder: [ :aLabel :anItem :anItemNode |
		| aText |
		aText := aBlockOrSymbol phlowValue: anItem withEnoughArguments: { anItem. anItemNode. aLabel. self }.
		aLabel text: aText gtDisplayText asRopedText. ]
]

{ #category : 'private - building' }
TGtPhlowItemText >> newItemLabel [
	^ BrLabel new
		aptitude: BrGlamorousListLabelAptitude;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]
