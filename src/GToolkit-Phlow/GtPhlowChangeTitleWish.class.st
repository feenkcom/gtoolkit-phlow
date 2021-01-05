"
I am ${class:BrWish}$.
I am an abstract class.
I notify ${class:BlElement}$ that a title should be changed.
The title can be composed of an ${method:GtPhlowChangeTitleWish>>#iconDo:|label=icon}$ and a ${method:GtPhlowChangeTitleWish>>#labelDo:|label=label}$.
!! Collaborators
${class:GtPhlowTitleNotifier}$ fires instances of my subclasses.
!! Other information
See my ${class:GtPhlowChangeTitleWish|show=#gtSubclassesFor:|label=subclasses|expanded=true|height=130}$ for specific examples:
!! Examples
See ${class:GtPhlowTitleNotifier|show=#gtSubclassesFor:|expanded=true|height=130}$ subclasses for specific examples:

"
Class {
	#name : #GtPhlowChangeTitleWish,
	#superclass : #BrWish,
	#category : #'GToolkit-Phlow-Tool - Title'
}

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> icon [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> iconDo: aBlock [
	self icon 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: BrGlamorousVectorIcons noIcon ]
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> label [
	^ nil
]

{ #category : #'api - accessing' }
GtPhlowChangeTitleWish >> labelDo: aBlock [
	self label 
		ifNotNil: aBlock
		ifNil: [ aBlock cull: '' ]
]

{ #category : #sending }
GtPhlowChangeTitleWish >> sendTo: anObject [
	anObject changeTitleWish: self
]
