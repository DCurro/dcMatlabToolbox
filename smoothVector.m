function interpolatedVector = smoothVector( vector, interpolationSize )
    interpolatedVector = imresize(vector,[1,ceil(numel(vector)/interpolationSize)]);
    interpolatedVector = imresize(interpolatedVector,[1,numel(vector)]);
end

