function [fig] = figureForFlownetLog( flownetLogFilePath, shouldLogplot, shouldHide )
    cellArray = parseFlownetLog(flownetLogFilePath);

    visibleString = 'on';
    if shouldHide==1
        visibleString = 'off';
    end
    
    fig = figure('visible',visibleString); 
    hold on; 
    if shouldLogplot
        set(gca, 'yscale', 'log');
    end
    
    trainEpocLossMat = cellArray{1};
    testEpocLossMat  = cellArray{2};
    
    hasTrainMat = ~isempty(trainEpocLossMat);
    hasTestMat = ~isempty(testEpocLossMat);
    
    if hasTrainMat && hasTestMat
        plot(trainEpocLossMat(:,1),trainEpocLossMat(:,2),testEpocLossMat(:,1),testEpocLossMat(:,2));       
    elseif hasTrainMat
        plot(trainEpocLossMat(:,1),trainEpocLossMat(:,2));
    elseif hasTestMat
        plot(testEpocLossMat(:,1),testEpocLossMat(:,2));
    else
        display('nothing to plot..');
    end
    
    maxIteration = trainEpocLossMat(end,1);
    maxLoss = max(trainEpocLossMat(:,2));
    axis([0 maxIteration, 0 maxLoss]);
    
    title('Training');
    ylabel('loss');
    xlabel('iteration');
    legend('train', 'test');
    
    hold off;
end

