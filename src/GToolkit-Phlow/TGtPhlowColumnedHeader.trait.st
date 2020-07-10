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
		| aWrapper aLabel aScaledLabel |
		
		aWrapper := BlElement new.
		aWrapper layout: BlLinearLayout vertical.
		aWrapper constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical matchParent ].
		
		aLabel := eachColumn createHeaderRowElement.

		aScaledLabel := aLabel asScalableElement.
		aScaledLabel maxScale: 1.
		aScaledLabel constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c ignoreByLayout ].
		
		theItems ifNotEmpty: [
			| aRowElement  |
			aRowElement := self performBlock: [ 
				eachColumn createRowElementFor: theItems first atIndex: 1 ].
			aRowElement visibility: BlVisibility hidden.

			eachColumn resizer ifNotNil: [ :aLayoutResizer |
				aRowElement constraintsDo: [ :c |
					c horizontal resizer: aLayoutResizer.
					c vertical matchParent ].
				aWrapper constraintsDo: [ :c | c horizontal resizer: aLayoutResizer ].
				aRowElement dispatchEvent: (BrLayoutHorizontalResizerWish resizer: aLayoutResizer).
				aRowElement dispatchEvent: (BrLayoutVerticalResizerWish matchParent) ].
			
			aWrapper addChild: aRowElement	].
		
		aWrapper addChild: aScaledLabel.
		aWrapper
	]).
]

{ #category : #'private - accessing' }
TGtPhlowColumnedHeader >> columns [
	<return: #Collection of: #GtPhlowColumn>
	^ self explicitRequirement
]
