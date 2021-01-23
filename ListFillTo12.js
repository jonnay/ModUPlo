//

outlets = 1;

function list() {
	var collect = [];
	var index = 0;
	var lastGood = 0;
	
	for(var i=0; i < 12; i++) {
		if (arguments[index] == i) {
			collect.push(i);
			index++;
			lastGood = i;
		} else {
			collect.push(lastGood);
		}
	}
	outlet(0, collect)	  	
}