int greatest = 0; 

int i = 128;
for (i = 128; i < 148; i++) {
	int left = Mem{i};
	int j = 0;
	for (j = 128; j < 148; j++) {
		int right = Mem{j};
		if (greatest < hammingDistance(left, right)) {
			greatest = hammingDistance(left, right);
		}
	} 
}

hammingDistance(left, right) {
	count = 0;
	right = left xor right;
	while (right) {
		if (right & 1) {
			count++;
		}
		right = right >> 1;
	}
	return count;
}