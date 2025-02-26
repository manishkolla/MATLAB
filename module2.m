% (1) Download and load the original image
original_image = imread('/MATLAB Drive/digital_images_week2_quizzes_lena.gif'); % Replace with the actual path to your image

% (2) Convert the original image to type 'double'
original_image_double = double(original_image);

% (3) Create a 3x3 low-pass filter with all coefficients equal to 1/9
low_pass_filter = ones(5, 5) / 30;

% (4) Apply the low-pass filter to the original image using imfilter
filtered_image = imfilter(original_image_double, low_pass_filter, 'replicate');

% (5) Compute the MSE between the original and filtered images
MSE = sum(sum((original_image_double - filtered_image).^2)) / (256 * 256);

% Compute the PSNR
MAX_I = 255;  % Maximum pixel value for 8-bit images
PSNR = 10 * log10(MAX_I^2 / MSE);

% Display the results
fprintf('MSE: %f\n', MSE);
fprintf('PSNR: %f\n', PSNR);

% Optionally, display the images
figure;
subplot(1,2,1);
imshow(original_image);
title('Original Image');

subplot(1,2,2);
imshow(filtered_image, []);
title('Filtered Image');
