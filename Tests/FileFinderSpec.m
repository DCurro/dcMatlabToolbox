classdef FileFinderSpec < matlab.unittest.TestCase
    
    methods (Test)
        
        function test_finding_all_script_files_in_folder(testCase)
            fileList = FileFinder.findAllFilePathsInDirectoryEndingWithSuffix('FileFinderSpecFolder/','.m');
            
            expectedLengthOfList = 1;
            actualLengthOfList = size(fileList, 1);
            
            testCase.verifyEqual(actualLengthOfList, expectedLengthOfList);
        end
        
        function test_finding_all_script_files_recursively_in_folder(testCase)
            fileList = FileFinder.findAllFilePathsInDirectoryEndingWithSuffixRecursive('FileFinderSpecFolder/','.m');
            
            expectedLengthOfList = 2;
            actualLengthOfList = size(fileList, 1);
            
            testCase.verifyEqual(actualLengthOfList, expectedLengthOfList);
        end
        
    end
    
end

