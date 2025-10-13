"
I am a basic Phlow context that can store key-value information.


"
Class {
	#name : #GtPhlowContext,
	#superclass : #GtPhlowExecutionContext,
	#traits : 'TGtOptions + TGtPhlowWithSelfObjectHolder + TGtPhlowWithBehaviorHolder',
	#classTraits : 'TGtOptions classTrait + TGtPhlowWithSelfObjectHolder classTrait + TGtPhlowWithBehaviorHolder classTrait',
	#category : #'GToolkit-Phlow-Context'
}

{ #category : #accessing }
GtPhlowContext >> at: aKey [
	^ self optionAt: aKey ifPresent: #yourself ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPhlowContext >> at: aKey ifAbsent: aValuable [

	^ self optionAt: aKey ifAbsent: aValuable
]

{ #category : #accessing }
GtPhlowContext >> at: aKey ifAbsentPut: aValuable [
	^ self optionAt: aKey ifAbsentPut: aValuable
]

{ #category : #accessing }
GtPhlowContext >> at: aKey ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	^ self
		  optionAt: aKey
		  ifPresent: aPresentBlock
		  ifAbsent: anAbsentBlock
]

{ #category : #accessing }
GtPhlowContext >> at: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock [

	^ self optionAt: aKey ifPresent: aPresentBlock ifAbsentPut: anAbsentBlock
]

{ #category : #accessing }
GtPhlowContext >> at: aKey put: aValue [
	^ self optionAt: aKey put: aValue
]
