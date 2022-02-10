"
I am a demo class for {{gtClass:GtPhlowViewActionTarget}}. 
"
Class {
	#name : #GtPhlowWithViewActionTarget,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples - Support'
}

{ #category : #'gt - extensions' }
GtPhlowWithViewActionTarget >> gtDemoActionWithTargetFor: anAction [

	<gtAction>
	^ anAction button
		  priority: 1;
		  target:
			  (GtPhlowActionTarget forViewSelector: #gtMyDemoFor:);
		  label: 'HERE I AM!';
		  icon: BrGlamorousIcons greencircle;
		  tooltip:
			  'I am an action that is displayed in a default position (inspector top-right toolbar)';
		  action: [ :aButton :aTab | aButton label: 'Yes! It is me :-)' ]
]

{ #category : #accessing }
GtPhlowWithViewActionTarget >> gtMyDemoFor: aView [

	<gtView>
	^ aView list
		  title: 'My Demo';
		  priority: 1;
		  items: [ 1 to: 21 ]
]

{ #category : #examples }
GtPhlowWithViewActionTarget >> itself [

	<gtExample>
	^ self
]
