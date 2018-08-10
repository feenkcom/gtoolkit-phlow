message performing
on: anObject perform: aMessageSymbol
	<return: #BlElement>
	^ [ anObject perform: aMessageSymbol with: self ] 
		on: Error 
		do: [ :anException | 
			anException freeze.
			GtPhlowViewWithError new 
				title: 'Error';
				error: anException ]