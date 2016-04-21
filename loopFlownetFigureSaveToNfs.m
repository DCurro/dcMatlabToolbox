while 1 
    % flownet crops
    
    logfilePath = '/scratch/d2curro/domFlownetCropSimple/train_half.log';
    figure = figureForFlownetLog(logfilePath, 0, 1);
    print(figure.Number,'flownet-crop.png','-dpng');
    copyfile('flownet-crop.png','/nfs/share/liveNetworkOutputs');
    
%     figure = figureForFlownetLog(logfilePath, 1, 1);
%     print(figure.Number,'flownet-crop-log.png','-dpng','-r0');
%     copyfile('flownet-crop-log.png','/nfs/share/liveNetworkOutputs');
    
    % flownet simple with yt dataset
    
    logfilePath = '/scratch/d2curro/domFlownetSimple_1_youtubeDataSet/caffe-train.log';
    figure = figureForFlownetLog(logfilePath, 0, 1);
    print(figure.Number,'flownet-original-crop.png','-dpng','-r0');
    copyfile('flownet-original-crop.png','/nfs/share/liveNetworkOutputs');
    
    pause(30);
end
