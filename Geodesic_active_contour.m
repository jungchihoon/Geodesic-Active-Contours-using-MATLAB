%
% Skeleton code for COSE490 Fall 2020 Assignment 3
%
% Won-Ki Jeong (wkjeong@korea.ac.kr)
%

clear all;
close all;

%
% Loading input image
%
Img=imread('coins-small.bmp');
Img=double(Img(:,:,1));

%
% Parameter setting
%
dt = 0.1;  % time step
c = 1.0;  % weight for expanding term
niter = 400;


%
% Initializing distance field phi
%
% Inner region : -1, Outer region : +1, Contour : 0
%
[numRows,numCols] = size(Img);
phi=ones(size(Img));
phi(10:numRows-10, 10:numCols-10)=-1;
%
% Compute g (edge indicator, computed only once)
%

% ToDO ------------------------
%       First way [Gaussian smoothing]
G = imgaussfilt(Img,1); % imgaussfilt(A, sigma) A:image
[x,y]=gradient(G);
f = x.^2+y.^2;
g = 1./(1+f); 
%      Second way[Gaussian smoothing]
%G=fspecial('gaussian',400,2);  % fspecial('gaussian', hsize, sigma)] 
%smooth_img = conv2(Img,G,'same');  % smooth image by Gaussiin convolution]
%[x,y] = gradient(smooth_img);
%f = x.^2+y.^2;
%g = 1./(1+f); 
% -----------------------------

%
% Level set iteration
%
for n=1:niter
    
    %
    % Level set update function
    %
    phi = levelset_update(phi, g, c, dt);    

    %
    % Display current level set once every k iterations
    %
    k = 10;
    if mod(n,k)==0
        figure(1);
        imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on; contour(phi, [0,0], 'r');
        str=['Iteration : ', num2str(n)];
        title(str);
    end
end


%
% Output result
%
figure(1);
imagesc(Img,[0, 255]); axis off; axis equal; colormap(gray); hold on;  contour(phi, [0,0], 'r');
str=['Final level set after ', num2str(niter), ' iterations'];
title(str);

