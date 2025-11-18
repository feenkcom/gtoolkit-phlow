Class {
	#name : #GtPhlowAnnouncingDefiningMethods,
	#superclass : #GtPhlowDefiningMethods,
	#traits : 'TGtAnnouncer',
	#classTraits : 'TGtAnnouncer classTrait',
	#instVars : [
		'announcer'
	],
	#category : #'GToolkit-Phlow-Collectors'
}

{ #category : #announcer }
GtPhlowAnnouncingDefiningMethods >> announcer [
	<return: #Announcer>
	^ announcer
]

{ #category : #'announcement handling' }
GtPhlowAnnouncingDefiningMethods >> handleMethodModified: aMethodModified [ 
	(self methods anySatisfy: [ :eachMethod | 
		eachMethod isDefined not or: [ 
			aMethodModified affectsMethod: eachMethod compiledMethod ]]) ifFalse: [ ^ self ].
	self notifyDefinitionUpdated
]

{ #category : #initialization }
GtPhlowAnnouncingDefiningMethods >> initialize [
	super initialize.
	announcer := Announcer new.
]

{ #category : #accessing }
GtPhlowAnnouncingDefiningMethods >> methods: anObject [
	super methods: anObject.
	self subscribeToSystem.
]

{ #category : #notifying }
GtPhlowAnnouncingDefiningMethods >> notifyDefinitionUpdated [
	self announce: GtPhlowDefinitionUpdated
]

{ #category : #initialization }
GtPhlowAnnouncingDefiningMethods >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodModified
		send: #handleMethodModified:
		to: self
]
