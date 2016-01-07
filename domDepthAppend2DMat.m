function concatenatedDepthMatrix = domDepthAppend2DMat( baseMat, appendingMat )    
    concatenatedDepthMatrix = baseMat;
    concatenatedDepthMatrix(:,:,end+1) = appendingMat;
end

