Class {
	#name : #GtPhlowCompositeToolExamples,
	#superclass : #GtPhlowToolExamples,
	#category : 'GToolkit-Phlow-Tool - Examples'
}

{ #category : #'examples - tools' }
GtPhlowCompositeToolExamples >> compositeTool [
	<gtExample>
	| aTool anElement |
	aTool := self basicCompositeTool.
	aTool addTool: self toolOne.
	aTool addTool: self toolTwo.

	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).

	^ aTool
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> compositeToolElement [
	<gtExample>
	| aTool anElement |
	aTool := self compositeTool.
	anElement := aTool asElement.
	^ anElement
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> compositeToolElement_TabOne_ChangeLabel [
	<gtExample>
	| aTabGroup aContent aLabel aPlusButton aSpace |
	aTabGroup := self compositeToolElement.
	aSpace := self putInSpace: aTabGroup.
	aContent := aTabGroup content.
	aLabel := (aContent childAt: 1) childAt: 1.
	aPlusButton := (aContent childAt: 1) childAt: 2.
	self assert: aLabel class equals: BrLabel.
	self assert: aPlusButton class equals: BrButton.
	
	"Change displayed object from tab one"
	aPlusButton action value: aPlusButton.
	self assert: aLabel text characters equals: 'Label One with shared value: 2'.
	
	"Switch to the tab two and check the displayed object"
	aTabGroup viewModel tabs second select.
	aContent := aTabGroup content.
	aLabel := (aContent childAt: 1) childAt: 1.
	aPlusButton := (aContent childAt: 1) childAt: 2.
	self assert: aLabel class equals: BrLabel.
	self assert: aPlusButton class equals: BrButton.
	self assert: aLabel text characters equals: 'Label Two with shared value: 2'.
	
	"Change displayed object from tab two"
	aPlusButton action value: aPlusButton.
	self assert: aLabel text characters equals: 'Label Two with shared value: 3'.
	
	"Switch to the tab one and check the displayed object"
	aTabGroup viewModel tabs first select.
	aContent := aTabGroup content.
	aLabel := (aContent childAt: 1) childAt: 1.
	aPlusButton := (aContent childAt: 1) childAt: 2.
	self assert: aLabel class equals: BrLabel.
	self assert: aPlusButton class equals: BrButton.
	self assert: aLabel text characters equals: 'Label One with shared value: 3'.
	
	aTabGroup removeFromParent.
	^ aTabGroup
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> compositeToolElement_TabOne_DefaultLabel [
	<gtExample>
	| aTabGroup aContent aLabel |
	aTabGroup := self compositeToolElement.
	aContent := aTabGroup content.
	aLabel := (aContent childAt: 1) childAt: 1.
	self assert: aLabel class equals: BrLabel.
	self assert: aLabel text characters equals: 'Label One with shared value: 1'.
	^ aTabGroup
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> compositeToolElement_TabTwo_DefaultLabel [
	<gtExample>
	| aTabGroup aContent aLabel |
	aTabGroup := self compositeToolElement.
	aTabGroup viewModel tabs second select.
	aContent := aTabGroup content.
	aLabel := (aContent childAt: 1) childAt: 1.
	self assert: aLabel class equals: BrLabel.
	self assert: aLabel text characters equals: 'Label Two with shared value: 1'.
	^ aTabGroup
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> plusElement: aTextChanger [
	<gtExample>
	| aValue |
	aValue := 1.
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude - BrGlamorousButtonExteriorAptitude;
		icon: BrGlamorousIcons add;
		label: 'Increase label number';
		fitContent;
		constraintsDo: [ :c | 
			c frame horizontal alignRight.
			c frame vertical alignCenter ];
		action: [ :aButton |
			"obtain current value and increase it."
			| aWish |
			aWish := GtPhlowToolChangedObjectWish new.
			aButton fireEvent: aWish.
			aWish hasObject ifTrue: [ aValue := aWish object ].
			aTextChanger value: (aValue := aValue + 1).
			aButton fireEvent: (GtPhlowToolObjectChangeWish new object: aValue) ]
]

{ #category : #'examples - elements' }
GtPhlowCompositeToolExamples >> toolElementWithLabel: aString [
	| aLabel aTextChanger |
	aLabel := self labelWithText: 'Label ', aString asString, ' with shared value: 1'.
	aTextChanger := [ :aNewString | aLabel text: 'Label ', aString asString, ' with shared value: ', aNewString asString ].
	^ BlElement new
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ];
		addEventHandler:
			(GtPhlowToolChangedObjectHandler new onChangeSend: #value: to: aTextChanger);
		addChild: aLabel;
		addChild: (self plusElement: aTextChanger)
]

{ #category : #'examples - tools' }
GtPhlowCompositeToolExamples >> toolOne [
	<gtExample>
	^ self toolWithLabel: 'One' color: (Color green alpha: 0.3)
]

{ #category : #'examples - tools' }
GtPhlowCompositeToolExamples >> toolTwo [
	<gtExample>
	^ self toolWithLabel: 'Two' color: (Color blue alpha: 0.3)
]

{ #category : #'examples - tools' }
GtPhlowCompositeToolExamples >> toolWithLabel: aString color: aColor [
	<gtExample>
	| aTool anElement |
	aTool := self basicValuableTool.
	aTool valuable:
		[ (self toolElementWithLabel: aString)
			background: aColor ].
	aTool name: aString.
	anElement := aTool asElementDo: [ :theElement | theElement ].
	self assert: (anElement isKindOf: BlElement).
	self assert: aTool name equals: aString.
	^ aTool
]
