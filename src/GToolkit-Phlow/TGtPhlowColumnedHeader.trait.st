"
I add methods that creates column headers for columned views ${class:GtPhlowColumnedListView}$ and ${class:GtPhlowColumnedTreeView}$.
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
	aHeader id: GtColumnedListHeaderId.
	aHeader constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self buildHeaderItems: theItems inHeader: aHeader.
	^ aHeader
]

{ #category : #'private - building' }
TGtPhlowColumnedHeader >> buildHeaderItems: theItems inHeader: aHeader [

	aHeader addChildren: (self columns collect: [ :eachColumn |
		eachColumn buildHeaderElement ]).
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
		  column: 'Title' text: #title;
		  column: 'Item' text: #itemComputation;
		  column: 'Stencil' text: #cellStencil
]
