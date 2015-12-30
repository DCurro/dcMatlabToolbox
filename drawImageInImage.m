function combinedImage = drawImageInImage( image, imageBase, leftX, topY)
    combinedImage = imageBase;

    baseHeight = size(imageBase,1);
    baseWidth = size(imageBase,2);
    
    imageHeight = size(image,1);
    imageWidth = size(image,2);
    
    rightX = leftX+imageWidth-1;
    bottomY = topY+imageHeight-1;
    [imageTop, imageBottom, imageLeft, imageRight] = boundBordersToDimensions(topY,bottomY,leftX,rightX,baseWidth,baseHeight);
    
    subImage = image(:,:,:);
    
    if size(subImage,1)>0 && size(subImage,2)>0
        combinedImage(imageTop:imageBottom,imageLeft:imageRight,:) = image;
    end
end

