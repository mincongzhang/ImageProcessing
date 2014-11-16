%region growing algorithm
I = imread('girl.jpg'); 
I = rgb2gray(I);

% select seeds; better to choose the pixel in the girl's forehead
imshow(I);hold on;
[seed_x,seed_y] = ginput(1);

%change seed to integer
seed_x = round(seed_x)
seed_y = round(seed_y)

%region grow
R = region_grow(I,seed_x,seed_y,3);

%%
%get ROC point
%My ROC function, loop with threshold from 1:255 
targets = BW;
X = zeros(1,255); 
Y = zeros(1,255);
for t = 1:255
    threshold = t;
    outputs = my_threshold(I,threshold);
    [TPR,FPR] = my_roc(targets,outputs);
    X(t) = FPR;
    Y(t) = TPR;
end
figure,plot(X,Y);title('ROC curve');xlabel('False Positive Rate (FPR)'); ylabel('True Positive Rate (TPR)');

[R_TPR,R_FPR] = my_roc(targets,R)
hold on;
%plot(R_FPR,R_TPR,'ro');text(R_FPR,R_TPR,'   region grow');
hold off;

%%
%compare with the thresholding algorithm
[m n] = size(I);
for i=1:m
    for j=1:n
        Thresh(i,j) = (I(i,j) >= 120);
    end
end
subplot(1,4,1), imshow(I);title('Girl Face');
subplot(1,4,2), imshow(Thresh);title('Estimated Threshold(=120)');
load('groundtruth.mat');
G = BW;
subplot(1,4,3), imshow(G);title('Segmented Ground Truth');
subplot(1,4,4), imshow(R);title('Region Grow');