%% Conversion program for NYY Depth Dataset v2 from .mat to jpgs
%Author: William Herbosch
%Research Project: Virtual Annotator 
%UCL 2018-19

%% CODE
clear; 

%Load in the data
%data = importdata('nyu_depth_v2_labeled.mat');
%Obtain the images
NYU_raw_images = data.images;
NYU_raw_depths = data.depths;

%Number of images
[H, W, RGBs, number] = size(NYU_raw_images);

%For every image in the dataset
for this_image = 1:number
    %Obtain the image/depth
    this_NYUraw_image = NYU_raw_images(:, :, :, this_image); 
    this_NYUdepths = NYU_raw_depths(:, :, this_image);     
    
    %Create visual from depth map
    %depth_map = imagesc(this_NYUdepths);
    %colorbar;
   
    %View image/depth
    %imshow(this_NYUraw_image);
    %imshow(this_NYUdepths);
    
    %Create string for storing image to jpg file
    convert_and_store = strcat('NYU_Images/NYU_RGBimage_', int2str(this_image),'.jpg');
    imwrite(this_NYUraw_image, convert_and_store);
    
    %Create string for storing depth to mat file
    convert_and_store = strcat('NYU_Depths/NYU_DepthMap_', int2str(this_image),'.mat');
    save(convert_and_store, 'this_NYUdepths'); 
end



