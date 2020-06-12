Class {
	#name : #GtPhlowSystemChangeUpdateDefinition,
	#superclass : #GtPhlowUpdateDefinition,
	#category : #'GToolkit-Phlow-Updating'
}

{ #category : #testing }
GtPhlowSystemChangeUpdateDefinition class >> isAbstract [
	^ self name = #GtPhlowSystemChangeUpdateDefinition 
]

{ #category : #schedulling }
GtPhlowSystemChangeUpdateDefinition >> scheduleTask: aTask [
	| aCommand |
	aCommand := BlTaskAtPostponedTerminableTask new
		command: aTask;
		pool: BlTktWorkerProvider highUICPUBoundPool;
		beShiftingNotScheduledHandler;
		scheduledTime: BlTime real now + 200 milliSeconds.
	BlTaskAtQueue default schedule: aCommand
]
