Class {
	#name : #GtPhlowContextExamples,
	#superclass : #Object,
	#instVars : [
		'contexts'
	],
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #support }
GtPhlowContextExamples >> contexts [

	^ contexts ifNil: [ contexts := OrderedCollection new ]
]

{ #category : #'gt - extensions' }
GtPhlowContextExamples >> rootListFor: aView context: aContext [

	<gtView>
	| aFormater aNewView |
	
	
	self assert: (aContext hasOptionAt: #gtBottomListFormater) not.
	
	aFormater := aContext at: #gtBottomListFormater ifAbsentPut: [ 
		             [ :aValue :anIndex | 
		             | aColor |
		             aColor := anIndex even
			                       ifTrue: [ Color green muchDarker alpha: 0.5 ]
			                       ifFalse: [ Color blue alpha: 0.5 ].
		             anIndex asRopedText
			             append: ': ' asRopedText;
			             append: aValue asRopedText;
			             foreground: aColor ] ].

	aNewView := aView forward
		            title: 'Root List';
		            priority: 3;
		            object: [ self ];
		            view: #middleListFor:.

	self contexts add: aNewView -> aContext.

	^ aNewView
]

{ #category : #accessing }
GtPhlowContextExamples >> sameContextFromCompositeView [
	<gtExample>
	| aContext aView anObject anElement allContexts aScripter |
	
	anObject := GtPhlowObjectWithTopViewMethod new.
	aContext := GtPhlowContext new.
	aView := GtPhlowView empty
		         on: anObject
		         perform: #gtViewsFor:inContext:
		         withContext: aContext.

	allContexts := aContext at: #allContexts ifAbsentPut: [ #(  ) ].

	self assert: allContexts size equals: 1.
	self assert: allContexts first key class equals: GtPhlowForwarderView.
	self assert: allContexts first value equals: aContext.

	aScripter := BlScripter new.
	aView asElementDo: [ :theElement | aScripter element: (anElement := theElement) ].

	self assert: allContexts size equals: 2.

	"First view"
	self assert: allContexts first key class equals: GtPhlowForwarderView.
	self assert: allContexts first value equals: aContext.

	"Second view"
	self
		assert: allContexts second key class
		equals: GtPhlowListView.

	"Second context"
	self assert: allContexts second value equals: aContext.

	^ aView
]

{ #category : #examples }
GtPhlowContextExamples >> sameContextFromRootToBottomList [
	<gtExample>
	| aContext aView anObject anElement allContexts aScripter |

	anObject := GtPhlowObjectWithTopViewMethod new.
	aContext := GtPhlowContext new.
	aView := GtPhlowView empty
		         on: anObject
		         perform: #rootListFor:context:
		         withContext: aContext.

	allContexts := aContext at: #allContexts ifAbsentPut: [ #(  ) ].

	self assert: allContexts size equals: 1.
	self assert: allContexts first equals: aView -> aContext.

	aScripter := BlScripter new.
	aView asElementDo: [ :theElement | aScripter element: (anElement := theElement) ].

	self assert: allContexts size equals: 2.

	"First view"
	self assert: allContexts first equals: aView -> aContext.

	"Second view"
	self
		assert: allContexts second key
		equals: aView phlowView wait phlowView wait.

	"Second context"
	self assert: allContexts second value equals: aContext.

	^ aView
]
