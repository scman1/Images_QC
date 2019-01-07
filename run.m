dirs=["..\input\qc_test_subsets\subset100\segments\*bcd*.jpg" 
"..\input\qc_test_subsets\subset100\segments\*clc*.jpg" 
"..\input\qc_test_subsets\subset150\segments\*bcd*.jpg" 
"..\input\qc_test_subsets\subset150\segments\*clc*.jpg"]

outs=["..\output\summary100cbd.txt" 
"..\output\summary100clc.txt" 
"..\output\summary150bcd.txt" 
"..\output\summary150clc.txt"]

for k = 1:4
    files=dir(dirs(k));

    names = [];
    complexityValues = [];
    colourfulnessValues = []
    contrastValues = [];
    sharpnessValues = [];
    disp(datetime('now'));
    for i=1:length(files)
        filename=[files(i).name];
        names = [names ""+filename];
        fullname = strcat(files(i).folder ,'\', files(i).name);

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

    % dlmwrite('..\output\names.txt',names,'delimiter',',');
    % dlmwrite('..\output\complexityValues.txt',complexityValues,'delimiter','');
    % dlmwrite('..\output\colourfulnessValues.txt',colourfulnessValues,'delimiter','');
    % dlmwrite('..\output\contrastValues.txt',contrastValues,'delimiter','');
    % dlmwrite('..\output\sharpnessValues.txt',sharpnessValues,'delimiter','');
    all_results = transpose(cat(1,names,complexityValues,colourfulnessValues,contrastValues,sharpnessValues))
    i = length(names)
    filePh = fopen(outs(k),'w');
    for j = 1:i
      fprintf(filePh,"%s,",all_results(j,:));
      fprintf(filePh,"\n");
    end
    fclose(filePh);
    disp(datetime('now'));
end