Extension { #name : #Behavior }

{ #category : #'*GToolkit-Phlow' }
Behavior >> gtThemedClassIconNamed: anIconName [
	| aGlyph aLabel |
	aGlyph := anIconName
			caseOf: {[ #string ] -> [ '¶' ].
					[ #magnitude ] -> [ 'Σ' ]}
			otherwise: [ ^ nil ].
	aLabel := BrLabel new.
	^ aLabel
		aptitude: (BrGlamorousLabelAptitude new
				foreground: aLabel theme label metadataTextForeground;
				fontSize: 12);
		text: aGlyph;
		alignCenter;
		exact: 16 @ 16
]
