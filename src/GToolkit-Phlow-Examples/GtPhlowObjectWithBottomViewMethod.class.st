Class {
	#name : #GtPhlowObjectWithBottomViewMethod,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Support'
}

{ #category : #'gt - extensions' }
GtPhlowObjectWithBottomViewMethod >> bottomListFor: aView context: aContext [

	<gtView>
	| aFormater aNewView |
	"Forward views may redifine how list items are displayed."
	aFormater := aContext 
		at: #gtBottomListFormater 
		ifAbsent: [ [ :aValue :anIndex | 
			anIndex asRopedText
				append: ' - ' asRopedText;
			    foreground: Color gray;
			    append: aValue asRopedText ] ].

	"View definition"
	aNewView := aView list
		            title: 'Bottom list';
		            priority: 1;
		            items: [ Collection allSubclasses ];
		            itemText: aFormater.

	"Testing purpose code"
	aContext
		at: #allContexts
		ifPresent: [ :aCollection | aCollection add: aNewView -> aContext ]
		ifAbsentPut: [ OrderedCollection with: aNewView -> aContext ].

	^ aNewView
]
