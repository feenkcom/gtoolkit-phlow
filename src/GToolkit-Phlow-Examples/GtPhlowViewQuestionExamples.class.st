Class {
	#name : #GtPhlowViewQuestionExamples,
	#superclass : #Object,
	#category : #'GToolkit-Phlow-Examples-Views'
}

{ #category : #views }
GtPhlowViewQuestionExamples >> gtListWithQuestionsFor: aView [
	<gtView>
	^ aView list
		title: 'Something';
		question: 'Why this?';
		question: 'Why that?';
		items: [ #(1 2) ]
]

{ #category : #examples }
GtPhlowViewQuestionExamples >> listWithQuestions [
	<gtExample>
	| aView aQuestion |
	aView := GtPhlowView empty on: self perform: #gtListWithQuestionsFor:.
	self assert: aView questions size equals: 2.
	self assert: aView questions first class equals: GtPhlowViewStringQuestion.
	self assert: aView questions second class equals: GtPhlowViewStringQuestion.
	self assert: aView questions first string equals: 'Why this?'.
	self assert: aView questions second string equals: 'Why that?'.
	aQuestion := GtPhlowViewStringQuestion string: 'Why this one?'.
	self assert: (aView question: aQuestion) == aView.
	self assert: aView questions size equals: 3.
	self assert: aView questions third == aQuestion.
	self assert: GtPhlowView empty list questions isEmpty.
	^ aView
]

{ #category : #examples }
GtPhlowViewQuestionExamples >> listWithoutQuestions [
	<gtExample>
	| aView |
	aView := GtPhlowView empty list.
	self assert: aView questions isEmpty.
	^ aView
]
