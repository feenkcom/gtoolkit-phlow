Class {
	#name : #GtPhlowObjectWithMiddleViewMethod,
	#superclass : #Object,
	#instVars : [
		'bottomObject'
	],
	#category : #'GToolkit-Phlow-Examples-Support'
}

{ #category : #accessing }
GtPhlowObjectWithMiddleViewMethod >> bottomObject [

	^ bottomObject ifNil: [ 
		  bottomObject := GtPhlowObjectWithBottomViewMethod new ]
]

{ #category : #'gt - extensions' }
GtPhlowObjectWithMiddleViewMethod >> middleListFor: aView [

	<gtView>
	^ aView forward
		            title: 'Middle list';
		            priority: 2;
		            object: [ self bottomObject ];
		            view: #bottomListFor:context:.
]
