Class {
	#name : #GtPhlowActionWithScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'GToolkit-Phlow-Examples-Core'
}

{ #category : #'examples - dropdown' }
GtPhlowActionWithScripterExamples >> dropdownWithIcon [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithPhlowAction: [ GtPhlowActionExamples new dropdownWithIcon ].

	aScripter click play.

	aScripter menuStep
		assertMenuContainerExist: 1;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPhlowActionWithScripterExamples >> dropdownWithIconAndLabel [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithPhlowAction: [ GtPhlowActionExamples new dropdownWithIconAndLabel ].

	aScripter click play.
	
	aScripter menuStep
		assertMenuContainerExist: 1;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPhlowActionWithScripterExamples >> dropdownWithIconAndLabelAndMenuItems [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithPhlowAction: [ GtPhlowActionExamples new dropdownWithIconAndLabelAndMenuItems ].

	aScripter click play.

	aScripter menuStep
		assertMenuContainerExist: 1;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPhlowActionWithScripterExamples >> dropdownWithIconAndLabelAndMenuModel [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithPhlowAction: [ GtPhlowActionExamples new dropdownWithIconAndLabelAndMenuModel ].

	aScripter click play.

	aScripter menuStep
		assertMenuContainerExist: 1;
		play.

	^ aScripter
]

{ #category : #'examples - dropdown' }
GtPhlowActionWithScripterExamples >> dropdownWithIconAndLabelAndResizer [
	<gtExample>
	| aScripter |
	aScripter := self
			scripterWithPhlowAction: [ GtPhlowActionExamples new dropdownWithIconAndLabelAndResizer ].

	aScripter click play.

	aScripter menuStep
		assertMenuContainerExist: 1;
		play.

	aScripter mouseMoveOver
		onSpaceRoot;
		// BrResizer;
		@ [ :aResizer | aResizer location isKindOf: BrResizerRightLocation ];
		play.

	(aScripter mouseDragBy: 50 @ 0)
		onSpaceRoot;
		// BrResizer;
		@ [ :aResizer | aResizer location isKindOf: BrResizerRightLocation ];
		play.
		
	aScripter assert
		label: 'Assert menu element size';
		value: [ :anElement | anElement extent ] equals: ((200 @ 300) + (50 @ 0));
		onSpaceRoot;
		onDropdown: true;
		onChildAt: 2;
		play.

	^ aScripter
]

{ #category : #'examples - scripter' }
GtPhlowActionWithScripterExamples >> scripterWithPhlowAction: aPhlowActionBlock [
	^ self
		scripterWithModel: aPhlowActionBlock
		element: [ :anAction | anAction asElement: [ :e | e ] withHostElement: nil ]
]
