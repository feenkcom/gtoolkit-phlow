"
I add a scripting method to display items as a text.
I am used by ${class:GtPhlowListView}$ and ${class:GtPhlowTreeView}$.

"
Trait {
	#name : #TGtPhlowItemText,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'api - scripting' }
TGtPhlowItemText >> itemDataBinder: aBrTreeNodeDataBinderOrBlock [
	self explicitRequirement
]

{ #category : #'api - scripting' }
TGtPhlowItemText >> itemStencil: aBrListItemElementStencilBuilderOrBlock [
	self explicitRequirement
]

{ #category : #'api - scripting' }
TGtPhlowItemText >> itemText: aBlockOrSymbol [
	self itemStencil: [ self newItemLabel ].
	self itemDataBinder: [ :aLabel :anItem :anItemNode |
		| aText |
		aText := aBlockOrSymbol phlowValue: anItem withEnoughArguments: { anItem. anItemNode. aLabel. self }.
		aLabel text: aText asRopedText. ]
]

{ #category : #'private - building' }
TGtPhlowItemText >> newItemLabel [
	^ BrLabel new
		look: BrGlamorousListLabelLook;
		alignCenterLeft;
		hMatchParent;
		vFitContent
]
