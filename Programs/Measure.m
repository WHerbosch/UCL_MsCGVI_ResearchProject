%% Obtaining measurements between two points on a depth map using pinhole camera model and Euclidean equation 
%Author: William Herbosch
%Research Project: Virtual Annotator 
%UCL 2018-19
%Credit to this paper: 
%https://www.ingentaconnect.com/contentone/ist/ei/2017/00002017/00000015/art00004?crawler=true&mimetype=application/pdf

%% CODE
clear;

% SETTINGS! Specify the names of the RGB and Depth images:
%Load in the data
depth_map = importdata('Dep_out_Regress.mat');
%image = imread('RGB_out.jpg');
image = imread('RGB_out.jpg');


%Obtain the original dimensions of the image
[Iw, Ih, Ichan] = size(image);
[Dw, Dh, Dchan] = size(depth_map);
%check if sizes are the same
if Iw ~= Dw || Ih ~= Dh
    disp("Dimensions of image and depth map do not match!");
end

%Resize all
depthBig = imresize(depth_map, 2);
imageBig = imresize(image, 2);
disp("Images loaded.");
disp(" ");

%Show RBG and hold
imshow(imageBig)
hold on;
%Obtain two coordinates
disp("Select one endpoint.");
[x1, y1]= ginput(1);
x1 = x1/2;
y1 = y1/2;
t = sprintf("Coordinates: [%d, %d]", x1, y1);
disp(t);
disp(" ");
disp("Select other endpoint.");
[x2, y2]= ginput(1);
x2 = x2/2;
y2 = y2/2;
t = sprintf("Coordinates: [%d, %d]", x2, y2);
disp(t);
line([x1*2, x2*2], [y1*2, y2*2],'Color','red', 'LineWidth', 10.0);
disp(" ");

%Ask for camera's focal length (in pixels).
disp("Please provide the focal length (in pixels) of the camera lense that took this image.");
disp("Note: Microsoft Kinect = 531, IPhone8 rear-camera = 106");
prompt = '-->';
focal_length = input(prompt);
disp(" ");

%Obtain the depth values from the corresponding coordinates on the depth
%map. 
Z1 = depth_map(uint8(y1), uint8(x1));
Z2 = depth_map(uint8(y2), uint8(x2));

%Compute centered points
cx = Ih/2;
cy = Iw/2;

%All values are entred, so we can now compute the distance betwen the
%points.
%FOR POINT P1:
X1 = ((x1 - cx) * Z1) / focal_length;
Y1 = ((y1 - cy) * Z1) / focal_length;
%FOR POINT P2:
X2 = ((x2 - cx) * Z2) / focal_length;
Y2 = ((y2 - cy) * Z2) / focal_length;

%Compute Euclidean Distance between the two points.
distance = sqrt(power((X1 - X2), 2) + power((Y1 - Y2), 2) + power((Z1 - Z2), 2));

%Return value:
l = sprintf("Measurement, given in metres: %f", distance);
disp(l);
