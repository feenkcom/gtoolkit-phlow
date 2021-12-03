Class {
	#name : #GtPhlowObjectWithTopViewMethod,
	#superclass : #Object,
	#instVars : [
		'middleObject'
	],
	#category : #'GToolkit-Phlow-Examples - Support'
}

{ #category : #accessing }
GtPhlowObjectWithTopViewMethod >> middleObject [

	^ middleObject ifNil: [ 
		  middleObject := GtPhlowObjectWithMiddleViewMethod new ]
]

{ #category : #'gt - extensions' }
GtPhlowObjectWithTopViewMethod >> rootListFor: aView context: aContext [

	<gtView>
	| aFormater aNewView |
	"Define a view specific text formater"
	aFormater := aContext 
		at: #gtBottomListFormater 
		ifAbsentPut: [ [ :aValue :anIndex | 
			| aColor |
			aColor := anIndex even
				ifTrue: [ Color green muchDarker alpha: 0.5 ]
			    ifFalse: [ Color blue alpha: 0.5 ].
		    anIndex asRopedText
			    append: ': ' asRopedText;
			    append: aValue asRopedText;
			    foreground: aColor ] ].

	"View definition"
	aNewView := aView forward
		            title: 'Root List';
		            priority: 1;
		            object: [ self middleObject ];
		            view: #middleListFor:.

	"Testing purpose code"
	aContext
		at: #allContexts
		ifPresent: [ :aCollection | aCollection add: aNewView -> aContext ]
		ifAbsentPut: [ OrderedCollection with: aNewView -> aContext ].

	^ aNewView
]
