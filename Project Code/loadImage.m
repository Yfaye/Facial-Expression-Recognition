function [numImage,img] = loadImage( strImagePath )
%LOADIMAGE read in the images from given file Path
%   numImage is the number of loaded Images
%   img is the matrix as the input for PCA process
%   to prepare for PCA, the loaded images are all substracted by mean image

% Constructing Image Loading Space and counting image numbers
structImages = dir(strImagePath);
lenImages = length(structImages);
Images='';

if (lenImages==0)
    disp('Error: No image was detected in the Image Folder');
    return;
end

i=0;
for j = 3:lenImages
     if ((~structImages(j).isdir))
         if  (structImages(j).name(end-3:end)=='.jpg')
             i=i+1;
             Images{i,1} = [strImagePath,'\',structImages(j).name];
         end
     end
end
numImage = i; % this is the number of loaded Images

% All Images are resized into a common size
imageSize = [280,180]; 


% Loading images
img = zeros(imageSize(1)*imageSize(2),numImage);
for i = 1:numImage
    aa = imresize(faceDetection(imresize(imread(Images{i,1}),[375,300])),imageSize);
    img(:,i) = aa(:);
    % disp(sprintf('Loading Image # %d',i));
end
% Generating the mean image
meanImage = mean(img,2);        

% Substracting the mean image from loaded image
img = (img - meanImage*ones(1,numImage))';     
end

