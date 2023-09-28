// % THIS LINE IS FOR INSTANTIATING A FIZ OBJECT (A FUZZI PACKAGE OBJECT)
fis = mamfis('Name', 'FaultDetectionFIS', 'AndMethod', 'min', 'OrMethod', 'max', 'ImpMethod', 'min', 'AggMethod', 'max', 'DefuzzMethod', 'centroid');

// % Define input variables (TEMPRATURES AND THE STANDARD PRESSURES)
fis = addInput(fis, [0 200], 'Name', 'Temperature');
fis = addMF(fis, 'input', 1, 'Name', 'Cold', 'Type', 'gaussmf', 'Parameters', [20 0]);
fis = addMF(fis, 'input', 1, 'Name', 'Cool', 'Type', 'gaussmf', 'Parameters', [20 70]);
fis = addMF(fis, 'input', 1, 'Name', 'Warm', 'Type', 'gaussmf', 'Parameters', [20 140]);
fis = addMF(fis, 'input', 1, 'Name', 'Hot', 'Type', 'gaussmf', 'Parameters', [20 200]);

fis = addInput(fis, [20 70], 'Name', 'Pressure');
fis = addMF(fis, 'input', 2, 'Name', 'Low', 'Type', 'gaussmf', 'Parameters', [10 20]);
fis = addMF(fis, 'input', 2, 'Name', 'Medium', 'Type', 'gaussmf', 'Parameters', [10 45]);
fis = addMF(fis, 'input', 2, 'Name', 'High', 'Type', 'gaussmf', 'Parameters', [10 70]);


// % Define OUTPUT variables (TEMPRATURES AND THE STANDARD PRESSURES)
fis = addOutput(fis, [0 3], 'Name', 'Fault');
fis = addMF(fis, 'output', 1, 'Name', 'NoFault', 'Type', 'gaussmf', 'Parameters', [0.5 0]);
fis = addMF(fis, 'output', 1, 'Name', 'MinorFault', 'Type', 'gaussmf', 'Parameters', [0.5 1]);
fis = addMF(fis, 'output', 1, 'Name', 'ModerateFault', 'Type', 'gaussmf', 'Parameters', [0.5 2]);
fis = addMF(fis, 'output', 1, 'Name', 'MajorFault', 'Type', 'gaussmf', 'Parameters', [0.5 3]);


// % Define THE RULES EXPECTED TO BE FOLLOWED FOR THE FUZZI
rule1 = [1 1 1 1 2 1]; % If Temperature is Cold and Pressure is Low, then Fault is MinorFault
rule2 = [2 1 2 1 3 1]; % If Temperature is Cool and Pressure is Low, then Fault is ModerateFault
% Define more rules as needed


// % IMPLEMENTING THE FUZZI RULES TO BE  USED  
fis = addRule(fis, [rule1; rule2]); % Add the rules defined above

// % Evaluate the FIS with input data
inputTemperature = 70; % Example temperature input
inputPressure = 35; % Example pressure input
output = evalfis([inputTemperature, inputPressure], fis);

// % Display the fuzzy output (Fault)
fprintf('Fault Level: %f\n', output);

// % Interpret the fuzzy output to determine the fault level
//%THIS LINE IS FOR INTERPRETING THE FAULTS ENCOUNTERED DURING THE RNNTIME PROCESS
if output <= 1
    fprintf('No Fault Detected\n');
elseif output <= 2
    fprintf('Minor Fault Detected\n');
elseif output <= 3
    fprintf('Moderate Fault Detected\n');
else
    fprintf('Major Fault Detected\n');
end
