"
I exemplify {{gtClass:GtPhlowSidebarElement}}.


"
Class {
	#name : #GtPhlowSidebarElementExamples,
	#superclass : #Object,
	#category : 'GToolkit-Phlow-Tool - Examples'
}

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> basicHorizontalSidebarElement [
	<gtExample>
	| anElement |
	anElement := GtPhlowHorizontalSidebarElement new.

	self assert: anElement contentStencil isNotNil.
	"An empty content and resizer"
	self assert: anElement childrenCount equals: 2.

	^ anElement
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> basicVerticalSidebarElement [
	<gtExample>
	| anElement |
	anElement := GtPhlowVerticalSidebarElement new.

	self assert: anElement contentStencil isNotNil.
	"An empty content and resizer"
	self assert: anElement childrenCount equals: 2.

	^ anElement
]

{ #category : #'examples - support' }
GtPhlowSidebarElementExamples >> contentElement [
	<gtExample>
	^ BrFrame new
		labeled: 'Content';
		matchParent
]

{ #category : #'examples - model' }
GtPhlowSidebarElementExamples >> contentStencil [
	<gtExample>
	^ [ BrFrame new
			matchParent;
			background: (Color blue alpha: 0.1);
			addChild: (BrLabel new
				aptitude: (BrGlamorousLabelAptitude new
					foreground: Color white);
				text: 'Sidebar Content';
				constraintsDo: [ :c | 
					c frame horizontal alignCenter.
					c frame vertical alignCenter ]) ] asStencil
]

{ #category : #'examples - support' }
GtPhlowSidebarElementExamples >> horizontalContainerElement [
	<gtExample>
	^ BrHorizontalPane new
		labeled: 'Container';
		matchParent
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_Default [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicHorizontalSidebarElement.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_Default_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_Default.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicHorizontalSidebarElement.
	anElement beLeft.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_LeftSide.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide_Offset_Bigger [
	<gtExample>
	| anElement |
	anElement := self horizontalSidebarElement_LeftSide.
	
	anElement offset: 42.
	
	self assert: anElement contentOffset length equals: 42.
	self assert: anElement contentElement margin right equals: 42.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide_Offset_Bigger_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_LeftSide_Offset_Bigger.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide_Offset_Smaller [
	<gtExample>
	| anElement |
	anElement := self horizontalSidebarElement_LeftSide.
	
	anElement offset: 0.
	
	self assert: anElement contentOffset length equals: 0.
	self assert: anElement contentElement margin right equals: 0.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_LeftSide_Offset_Smaller_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_LeftSide_Offset_Smaller.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicHorizontalSidebarElement.
	anElement beRight.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"The sidebar has a content and a resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - horizontal sidebar element' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_RightSide.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide_Offset_Bigger [
	<gtExample>
	| anElement |
	anElement := self horizontalSidebarElement_RightSide.
	
	anElement offset: 42.
	
	self assert: anElement contentOffset length equals: 42.
	self assert: anElement contentElement margin left equals: 42.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide_Offset_Bigger_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_RightSide_Offset_Bigger.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide_Offset_Smaller [
	<gtExample>
	| anElement |
	anElement := self horizontalSidebarElement_RightSide.
	
	anElement offset: 0.
	
	self assert: anElement contentOffset length equals: 0.
	self assert: anElement contentElement margin left equals: 0.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> horizontalSidebarElement_RightSide_Offset_Smaller_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self horizontalSidebarElement_RightSide_Offset_Smaller.
	aContainer := self horizontalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - support' }
GtPhlowSidebarElementExamples >> verticalContainerElement [
	<gtExample>
	^ BrVerticalPane new
		labeled: 'Container';
		matchParent
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicVerticalSidebarElement.
	anElement beBottom.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Bottom.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom_Offset_Bigger [
	<gtExample>
	| anElement |
	anElement := self verticalSidebarElement_Bottom.
	
	anElement offset: 42.
	
	self assert: anElement contentOffset length equals: 42.
	self assert: anElement contentElement margin top equals: 42.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom_Offset_Bigger_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Bottom_Offset_Bigger.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom_Offset_Smaller [
	<gtExample>
	| anElement |
	anElement := self verticalSidebarElement_Bottom.
	
	anElement offset: 0.
	
	self assert: anElement contentOffset length equals: 0.
	self assert: anElement contentElement margin top equals: 0.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Bottom_Offset_Smaller_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Bottom_Offset_Smaller.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Default [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicVerticalSidebarElement.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Default_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Default.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: self contentElement;
		addChild: anElement.

	^ aContainer
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top [
	<gtExample>
	| anElement aStencil aContentElement aResizerElement |
	anElement := self basicVerticalSidebarElement.
	anElement beTop.
	aContentElement := anElement childAt: 1.
	aResizerElement := anElement childAt: 2.

	aStencil := self contentStencil.
	anElement contentStencil: aStencil.

	self assert: anElement contentStencil equals: aStencil.
	"A content and resizer"
	self assert: anElement childrenCount equals: 2.
	self assert: (anElement childAt: 1) ~= aContentElement.
	self assert: (anElement childAt: 2) equals: aResizerElement.

	"The sidebar content has margin offset on the left"
	self assert: anElement contentElement margin equals: anElement contentOffset margin.

	^ anElement
]

{ #category : #'examples - vertical sidebar element' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Top.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top_Offset_Bigger [
	<gtExample>
	| anElement |
	anElement := self verticalSidebarElement_Top.
	
	anElement offset: 42.
	
	self assert: anElement contentOffset length equals: 42.
	self assert: anElement contentElement margin bottom equals: 42.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top_Offset_Bigger_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Top_Offset_Bigger.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top_Offset_Smaller [
	<gtExample>
	| anElement |
	anElement := self verticalSidebarElement_Top.
	
	anElement offset: 0.
	
	self assert: anElement contentOffset length equals: 0.
	self assert: anElement contentElement margin bottom equals: 0.

	^ anElement
]

{ #category : #'examples - offset' }
GtPhlowSidebarElementExamples >> verticalSidebarElement_Top_Offset_Smaller_InContainer [
	<gtExample>
	| anElement aContainer |
	anElement := self verticalSidebarElement_Top_Offset_Smaller.
	aContainer := self verticalContainerElement.
	aContainer
		addChild: anElement;
		addChild: self contentElement.

	^ aContainer
]
