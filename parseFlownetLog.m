function epocLossMatsCellArray = parseFlownetLog( flownetLogFilePath )
    
    rawIterationCommand = ['cat ',flownetLogFilePath,' | grep Iteration | grep loss > temp.txt'];
    system(rawIterationCommand);
    rawIterationString = fileread('temp.txt');
    
    rawTestCommand = ['cat ',flownetLogFilePath,' | grep Test > temp.txt'];
    system(rawTestCommand);
    rawTestString = fileread('temp.txt');

    displayCommand = ['cat ',flownetLogFilePath,' | grep "display:" > temp.txt'];
    system(displayCommand);
    rawDisplayString = fileread('temp.txt');
    splitRawDisplayString = strsplit(rawDisplayString,':');
    displayCount = str2double(splitRawDisplayString{2});
    
    displayCommand = ['cat ',flownetLogFilePath,' | grep "test_interval:" > temp.txt'];
    system(displayCommand);
    rawDisplayString = fileread('temp.txt');
    splitRawDisplayString = strsplit(rawDisplayString,':');
    testInvervalCount = displayCount*100;
    if ischar(splitRawDisplayString)
        testInvervalCount = max(1,str2double(splitRawDisplayString{2}));
    end
    
    smoothingFactor = testInvervalCount/displayCount;
    
    trainEpocLossMat = rawIterationStringToEpocLossMat(rawIterationString, smoothingFactor);
    testEpocLossMat = rawTestStringToEpocLossMat(rawTestString);
    
    epocLossMatsCellArray = {trainEpocLossMat, testEpocLossMat};
end

function epocLossMat = rawIterationStringToEpocLossMat(rawIterationString, smoothingFactor)
    if isempty(rawIterationString)
        epocLossMat = [];
        return;
    end

    iterationStringWithoutFinalNewline = rawIterationString(1:end-1);

    iterationCellArray = strsplit(iterationStringWithoutFinalNewline, '\n');
    cellCount = size(iterationCellArray,2);
    
    epocLossMat = zeros([cellCount,2]);
    
    for i=1:cellCount
        fullstring = iterationCellArray{i};
        
        splitCellArray = strsplit(fullstring,' ');
        
        iterationStringWithComma = splitCellArray{end-3};
        iteartionString = iterationStringWithComma(1:end-1);
        lossString = splitCellArray{end};
        
        epocLossMat(i,1) = str2double(iteartionString);
        epocLossMat(i,2) = str2double(lossString);
    end
    
    oldSize = cellCount;
    newSize = max(ceil(cellCount/smoothingFactor),1);
    losses = epocLossMat(:,2);
    smoothedLosses = imresize(losses,[newSize,1]);
    epocLossMat(:,2) = imresize(smoothedLosses,[oldSize,1]);
end

function epocLossMat = rawTestStringToEpocLossMat(rawTestString)
    if isempty(rawTestString)
        epocLossMat = [];
        return;
    end

    testStringWithoutFinalNewline = rawTestString(1:end-1);

    testCellArray = strsplit(testStringWithoutFinalNewline, '\n');
    cellCount = size(testCellArray,2);

    lossPerIterationCount = 0;
    for i=1:cellCount
        fullstring = testCellArray{i};
        
        splitCellArray = strsplit(fullstring,' ');
        
        if isequal(splitCellArray{5},'Iteration')
            if lossPerIterationCount > 0
                break;
            end
        else            
            lossPerIterationCount = lossPerIterationCount+1;
        end
    end
    
    numberOfElementsPerIteration = lossPerIterationCount+1; % +1 for the Iteartion header
    epocLossMat = zeros([floor(cellCount/numberOfElementsPerIteration),2]);
    
    structCount = 0;
    for i=1:floor(cellCount/numberOfElementsPerIteration)*numberOfElementsPerIteration
        fullstring = testCellArray{i};
        
        splitCellArray = strsplit(fullstring,' ');
        
        if isequal(splitCellArray{5},'Iteration')
            structCount = structCount+1;
            
            iterationStringWithComma = splitCellArray{6};
            iterationString = iterationStringWithComma(1:end-1);
            epocLossMat(structCount,1) = str2double(iterationString);
        else
            matches = strfind(fullstring,'accuracy');
            if any(vertcat(matches(:)))
                continue;
            end
            
            lastString = splitCellArray{end};
            secondLastString = splitCellArray{end-1};
            
            lossString = '';
            
            if all(ismember(lastString, '0123456789+-.eEdD'))
                lossString = lastString;
            else
                lossString = secondLastString;
            end
            
            epocLossMat(structCount,2) = epocLossMat(structCount,2) + str2double(lossString);
        end
    end
    
end