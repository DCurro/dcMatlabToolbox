clc
import matlab.unittest.TestSuite
suiteFolder = TestSuite.fromFolder('./Tests');
result = run(suiteFolder);