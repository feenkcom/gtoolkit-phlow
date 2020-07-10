Trait {
	#name : #TGtPhlowColumnedHeader,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #'private - building' }
TGtPhlowColumnedHeader >> buildHeaderForItems: theItems [
	| aHeader |
	aHeader := BlElement new.
	aHeader layout: (BlLinearLayout horizontal alignCenterLeft cellSpacing: 10).
	aHeader padding: (BlInsets top: 5 bottom: 5).
	aHeader labeled: 'Columned Header'.
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

{ #category : #'private - accessing' }
TGtPhlowColumnedHeader >> columns [
	<return: #Collection of: #GtPhlowColumn>
	^ self explicitRequirement
]
