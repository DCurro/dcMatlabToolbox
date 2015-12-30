function [newTop,newBottom,newLeft,newRight] = boundBordersToDimensions( top,bottom,left,right,width,height )
    newTop = top;
    newBottom = bottom;
    newLeft = left;
    newRight = right;

    if top < 1
       newTop = 1; 
    end
    if bottom > height
        newBottom = height;
    end
    if left < 1
       newLeft = 1; 
    end
    if bottom > width
        newRight = width;
    end
end

