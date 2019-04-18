"
I define ${method:TGtPhlowWithIcon>>#newIconElement|expanded=true}$ that convert an ${method:TGtPhlowWithIcon>>#icon}$ to its ${class:BlElement}$ widget.
"
Trait {
	#name : #TGtPhlowWithIcon,
	#category : #'GToolkit-Phlow-Support'
}

{ #category : #accessing }
TGtPhlowWithIcon >> icon [
	"Icon can be a String, Symbol, Form or another object understanding #asElement message"
	^ self explicitRequirement
]

{ #category : #'instance creation' }
TGtPhlowWithIcon >> newIconElement [
	<return: #BlElement>
	self 
		assert: [ self icon isNotNil ]
		description: [ 'Button icon must be initialized' ].
	self icon isString ifTrue: [ 
		(BrGlamorousIcons respondsTo: self icon asSymbol) 
			ifTrue: [ ^ (BrGlamorousIcons perform: self icon asSymbol) asElement ]
			ifFalse: [ ^ (self iconNamed: self icon asSymbol) asElement ] ].
	^ self icon asElement.
]
