Extension { #name : #BrTab }

{ #category : #'*GToolkit-Phlow' }
BrTab >> viewContentElement [
	"A tab that is marked as a isViewTitle can find
	the related content element by going through the parentTabGroup"
	self 
		assert: [ self phlow isViewTitle ]
		description: [ 'Phlow context must be a view' ].
	
	^ self parentTabGroup
		allChildrenBreadthFirstDetect: [ :each | each phlow isViewContent ] 
		ifFound: [ :viewContentElement | viewContentElement ]
		ifNone: [ self error: 'No content element found!' ]
]
