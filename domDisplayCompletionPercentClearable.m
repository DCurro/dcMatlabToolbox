function domDisplayCompletionPercentClearable( prefixMessage, currentIterationIndex, maxIterationIndex )
    persistent lastDisplayString;
    if ~isempty(lastDisplayString) 
            %clear last message written with this method
            fprintf(repmat('\b',1,numel(lastDisplayString)+2)); 
    end

    displayString = [prefixMessage,' - ',num2str(100*currentIterationIndex/maxIterationIndex),'%'];
    fprintf('\n%s',displayString);
    
    lastDisplayString = displayString; %+ the \n character
end

