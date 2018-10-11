%   train_lim_out_data - input data.
%   output_2_lim - target data.

x = train_lim_out_data';
t = output_2_lim';

% Choose a Training Function
trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.

% Create a Pattern Recognition Network
hiddenLayerSize = 100;
net = patternnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,x,t);

% Test the Network, output and error
y = net(x);
e = gsubtract(t,y);

% Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
trainPerformance = perform(net,trainTargets,y);
valPerformance = perform(net,valTargets,y);
testPerformance = perform(net,testTargets,y);
trainConfusion = confusion(trainTargets,y);
valConfusion = confusion(valTargets,y);
testConfusion = confusion(testTargets,y);

%Save in a struct variable:
res = struct('net',[],'info',[],'output',[],'error',[]);
res.net = net;
res.output = y;
res.error = e;
res.info = struct('train',[],'validation',[],'test',[]);
res.info.train = struct('indices',[],'performance',[],'confusion',[]);
res.info.validation = struct('indices',[],'performance',[],'confusion',[]);
res.info.test = struct('indices',[],'performance',[],'confusion',[]);
res.info.train.indices = tr.trainInd;
res.info.train.performance = trainPerformance;
res.info.train.confusion = trainConfusion;
res.info.validation.indices = tr.testInd;
res.info.validation.performance = valPerformance;
res.info.validation.confusion = valConfusion;
res.info.test.indices = tr.valInd;
res.info.test.performance = testPerformance;
res.info.test.confusion = testConfusion;






