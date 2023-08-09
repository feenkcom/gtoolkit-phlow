"
I am a demo class for {{gtClass: GtPhlowObjectActionTarget }}.
"
Class {
	#name : #GtPhlowWithObjectActionTarget,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Support'
}

{ #category : #'gt - extensions' }
GtPhlowWithObjectActionTarget >> gtDemoActionWithTargetFor: anAction [

	<gtAction>
	^ anAction button
		  priority: 1;
		  label: 'HERE I AM!';
		  icon: BrGlamorousIcons greencircle;
		  tooltip:
			  'I am an action that is displayed in a default position (inspector top-right toolbar)';
		  action: [ :aButton :aTab | aButton label: 'Yes! It is me :-)' ]
]

{ #category : #examples }
GtPhlowWithObjectActionTarget >> itself [

	<gtExample>
	^ self
]
