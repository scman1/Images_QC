files=dir('input\originalsBR96\*.jpg');

names = [];
complexityValues = [];
colourfulnessValues = []
contrastValues = [];
sharpnessValues = [];

for i=1:length(files)
	filename=[files(i).name];
	names = [names char(10) filename];
    fullname = strcat(files(i).folder ,'\', files(i).name);
    disp(datetime('now'));

	a = imread(fullname);

  	complexity(a,50);
  	complexityValues = [complexityValues ans];

	getColourfulness(a);
	colourfulnessValues = [colourfulnessValues ans];

	getGlobalContrastFactor(a);
	contrastValues = [contrastValues ans];

	[sharpnessScore map]= MLVSharpnessMeasure(a);
	sharpnessValues = [sharpnessValues sharpnessScore];
end

dlmwrite('output\names.txt',names,'delimiter','');
dlmwrite('output\complexityValues.txt',complexityValues,'delimiter',' ');
dlmwrite('output\colourfulnessValues.txt',colourfulnessValues,'delimiter',' ');
dlmwrite('output\contrastValues.txt',contrastValues,'delimiter',' ');
dlmwrite('output\sharpnessValues.txt',sharpnessValues,'delimiter',' ');
disp(datetime('now'));
