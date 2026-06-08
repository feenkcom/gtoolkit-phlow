Class {
	#name : #GtPhlowMultipleViewsToolStep,
	#superclass : #GtPhlowViewsBasedToolStep,
	#category : #'GToolkit-Phlow-Examples'
}

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolLabel: aString [
	<gtExample>
	
	^ self assert
			label: 'Tool name label is ', aString ;
			value: [ :aLabel | aLabel text asString ] equals: [ aString ];
			onParentStepTarget: self;
			// #header;
			// #toolLabel.
]

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolObjectOfType: aClass [
	self assert
		label: ('Assert tool model object has type {1}' format: {aClass name});
		value: [ :aToolModel | aToolModel targetObject class ]
			equals: aClass;
		onParentStepTarget: self;
		onChildFromMessage: #toolContentModel
]

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolObjectSatisfies: aBlockClosure description: aStringOrBlockCosure [
	self 
		assertToolObjectSatisfies: aBlockClosure 
		description: aStringOrBlockCosure 
		label: 'Assert tool object matches condition'
]

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolObjectSatisfies: aBlockClosure description: aStringOrBlockCosure label: aLabel [
	self assert
		label: aLabel;
		satisfies: [ :anToolModel | 
				aBlockClosure value: anToolModel targetObject ]
			description: aStringOrBlockCosure;
		onParentStepTarget: self;
		onChildFromMessage: #toolContentModel
]

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolObjectValueFor: aBlockClosure equals: aValue [
	self assert
		label: ('Assert tool model object computation equals value');
		value: [ :aToolModel | aBlockClosure value: aToolModel targetObject ]
			equals: aValue;
		onParentStepTarget: self;
		onChildFromMessage: #toolContentModel
]

{ #category : #'steps - checks' }
GtPhlowMultipleViewsToolStep >> assertToolTitle: aString [
	<gtExample>
	
	^ self assert
			label: 'Tool title label is ', aString ;
			value: [ :aLabel | aLabel text asString ] equals: [ aString ];
			onParentStepTarget: self;
			// #titleContainer;
			// #titleLabel
]
