[label1,inst1] = libsvmread('C:/Users/voidpassion/Documents/second/stantest9.txt');
[label, inst] = libsvmread('C:/Users/voidpassion/Documents/second/stantrain9.txt');

%此为回归SVM
%model1 = svmtrain (label, inst, '-s 3 -t 2 -g 0.0625 -c 16 -p 1 ');
%model2 = svmtrain(label, inst, '-s 4 -t 2 -g 0.0625 -c 16 -p 1');

%分类SVM
model1 = svmtrain (label, inst, '-s 0 -t 2 -g 0.0625 -c 4');

[predict_label, accuracy, dec_values] = svmpredict(label, inst, model1);
[py1,mse] = svmpredict(label,inst,model1);
figure;
plot(inst,label,'o');
hold on;
plot(inst,py1,'r*');
legend('原始数据1','回归数据1');
grid on;

[predict_label, accuracy, dec_values] = svmpredict(label1, inst1, model1);
[pr1,mse] = svmpredict(label1,inst1,model1);
figure;
plot(inst1,label1,'o');
hold on;
plot(inst1,pr1,'r*');
legend('测试数据1','回测数据1');
grid on;
