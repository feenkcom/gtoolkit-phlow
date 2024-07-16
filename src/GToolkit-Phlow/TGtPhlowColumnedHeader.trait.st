"
I add methods that creates column headers for columned views {{gtClass:GtPhlowColumnedListView}} and {{gtClass:GtPhlowColumnedTreeView}}.

"
Trait {
	#name : #TGtPhlowColumnedHeader,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
TGtPhlowColumnedHeader >> buildHeaderForItems: theItems [
	| aHeader |
	aHeader := BlElement new.
	aHeader layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: self cellSpacing).
	aHeader padding: (BlInsets top: 5 bottom: 5).
	aHeader id: GtPhlowColumnedListHeaderId.
	aHeader constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self buildHeaderItems: theItems inHeader: aHeader.
	^ aHeader
]

{ #category : #'private - building' }
TGtPhlowColumnedHeader >> buildHeaderItems: theBrickColumns inHeader: aHeader [	
	aHeader addChildren: (self columns with: theBrickColumns collect: [ :eachColumn :eachBrickColumn |
		| eachHeaderElement eachResizer |
		eachHeaderElement := eachColumn buildHeaderElement.
		eachResizer := BrResizer new
			id: (eachColumn title, '-resizer') asSymbol;
			aptitude: BrGlamorousThinBarResizerAptitude;
			beRight;
			target: eachHeaderElement;
			constraintsDo: [ :c | c ignoreByLayout ];
			when: BlResizerResizedEvent
				do: [ :anEvent | eachBrickColumn width: anEvent extent x ].
		eachHeaderElement addChild: eachResizer.
		eachHeaderElement ])
]

{ #category : #accessing }
TGtPhlowColumnedHeader >> cellSpacing [
	^ self explicitRequirement
]

{ #category : #'private - accessing' }
TGtPhlowColumnedHeader >> columns [
	<return: #Collection of: #GtPhlowColumn>
	^ self explicitRequirement
]

{ #category : #'gt - extensions' }
TGtPhlowColumnedHeader >> gtColumnsFor: aView [

	<gtView>
	self columns ifNil: [ ^ aView empty ].
	^ aView columnedList
		  title: 'Columns';
		  items: [ self columns ];
		  column: 'Title' text: #title weight: 0.25;
		  column: 'Item' text: #itemComputation
]
