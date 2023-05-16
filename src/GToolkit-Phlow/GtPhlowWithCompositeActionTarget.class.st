"
I am a demo class for {{gtClass:GtPhlowCompositeActionTarget}}. 
"
Class {
	#name : #GtPhlowWithCompositeActionTarget,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples - Support'
}

{ #category : #'gt - extensions' }
GtPhlowWithCompositeActionTarget >> gtDemoActionWithTargetFor: anAction [

	<gtAction>
	^ anAction button
		  priority: 1;
		  target: GtPhlowActionTarget default,
			  (GtPhlowActionTarget forViewSelector: #gtMyDemoFor:);
		  label: 'HERE I AM!';
		  icon: BrGlamorousIcons greencircle;
		  tooltip:
			  'I am an action that is displayed in two places';
		  action: [ :aButton :aTab | aButton label: 'Yes! It is me :-)' ]
]

{ #category : #accessing }
GtPhlowWithCompositeActionTarget >> gtMyDemoFor: aView [

	<gtView>
	^ aView list
		  title: 'My demo';
		  priority: 1;
		  items: [ 1 to: 21 ]
]

{ #category : #examples }
GtPhlowWithCompositeActionTarget >> itself [

	<gtExample>
	^ self
]
