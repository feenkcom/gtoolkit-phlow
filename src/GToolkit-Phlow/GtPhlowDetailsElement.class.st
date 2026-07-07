Class {
	#name : #GtPhlowDetailsElement,
	#superclass : #BrFrame,
	#instVars : [
		'gridElement',
		'detailsView'
	],
	#category : #'GToolkit-Phlow-! Views'
}

{ #category : #initialization }
GtPhlowDetailsElement >> configureRowName: rowNameLabel value: rowValueLabel fromRow: aRow [
	| clickHandler eventSharer|
	
	clickHandler := BlEventHandler on: BlClickEvent
				do: 
					[:anEvent |

					rowValueLabel viewModel ifNotNil: [
						anEvent consumed: true.
						rowValueLabel phlow 
							spawnObject: (
								detailsView localSend 
									ifNil: [rowValueLabel viewModel model] 
									ifNotNil: [ :aBlock |
										aBlock cull: aRow cull: rowValueLabel viewModel model] ) ]].
	
	eventSharer := BlSharedEventDistributor shareEvents: {
		BlMouseEnterEvent.
		BlMouseLeaveEvent.
		BlMouseDownEvent.
		BlMouseUpEvent.
		BlDragLeaveEvent.
		BlDragEndEvent }.
	
	rowNameLabel addEventHandler: eventSharer.
	rowValueLabel addEventHandler: eventSharer.
	
	rowNameLabel addEventHandler: clickHandler.
	rowValueLabel addEventHandler: clickHandler
]

{ #category : #'building widgets' }
GtPhlowDetailsElement >> createHeaderCell: aString [
	^ (BrLabel new)
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
				hFitContent;
				padding: (BlInsets top: 3 left: 6 bottom: 3 right: 6);
				text: aString
]

{ #category : #'building widgets' }
GtPhlowDetailsElement >> createRowName: eachRow [
	^(BrLabel new)
		aptitude: (BrGlamorousLabelAptitude + BrGlamorousListItemAptitude);
		hFitContent;
		padding: (BlInsets top: 3 left: 6 bottom: 3 right: 6);
		constraintsDo: [ :c | c grid horizontal specAlignment: BlGridAlignment fill ];
		text: eachRow name
]

{ #category : #'building widgets' }
GtPhlowDetailsElement >> createRowValue: eachRow [
	| value text |
	[
		value := eachRow valueComputation value.
		text := eachRow textComputation value: value.
	] 
		on: Exception 
		do: [ :anException |
			| anElement | 
			anElement := anException asDebuggableElement. 
			anElement id: GtPhlowExceptionId.
			anElement phlow beViewContent; entity: detailsView.
			^ anElement ].
	 
	^(BrLabel new)
		in: [:aLabel | aLabel viewModel model: value];
		aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude;
		hMatchParent;
		padding: (BlInsets
					top: 3
					left: 6
					bottom: 3
					right: 6);
		text: text
]

{ #category : #initialization }
GtPhlowDetailsElement >> detailsView: aDetailsView [
	detailsView := aDetailsView.
	self updateContent.
]

{ #category : #initialization }
GtPhlowDetailsElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	
	gridElement := BrHorizontalGrid new.
	gridElement columnCount: 2.
	gridElement cellSpacing: 0.
	gridElement hMatchParent.
	gridElement vFitContent.
			
	self addChild: gridElement.
]

{ #category : #initialization }
GtPhlowDetailsElement >> updateContent [
	| headerElements cellElements |
	
	gridElement removeChildren.
	
	headerElements := {
			self createHeaderCell: 'Name'.
			self createHeaderCell: 'Value' }.
	cellElements := detailsView  phlowDetailRows 
			flatCollect: [:eachRow |
					 | rowName rowValue |
					 rowName := self createRowName: eachRow.
					 rowValue := self createRowValue: eachRow.
					 
					 self configureRowName: rowName value: rowValue fromRow: eachRow.
					
					{ rowName . rowValue}].
					
	gridElement addChildren: headerElements.
	gridElement addChildren: cellElements.
]
