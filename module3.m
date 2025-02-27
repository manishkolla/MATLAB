original_img = imread('/MATLAB Drive/module3_img.jpg'); % Loading the 8-bit grayscale image
original_img = double(original_img); % Convert to double

filter = ones(3,3) / 9; % Creating a 3x3 Low Pass averaging filter
filtered_img = imfilter(original_img, filter, 'replicate'); % Applying filter with 'replicate' padding

downsampled_img = filtered_img(1:2:end, 1:2:end); % Removing every other row and column

upsampled_img = zeros(359, 479)18; % Creating an all-zeros image

% Assigning values from downsampled image
upsampled_img(1:2:end, 1:2:end) = downsampled_img;

interp_filter = [0.25, 0.5, 0.25; 0.5, 1, 0.5; 0.25, 0.5, 0.25]; % Interpolation filter
final_img = imfilter(upsampled_img, interp_filter); % Performing convolution

figure; % Create a new figure window

% Show the original image
subplot(1,2,1); % Create a 1-row, 2-column layout, first subplot
imshow(original_img, []); % Display original image
title('Original Image');

% Show the final up-sampled image
subplot(1,2,2); % Second subplot
imshow(final_img, []); % Display the final image
title('Final Up-Sampled Image');


mse = mean((original_img(:) - final_img(:)).^2); % Computing Mean Squared Error
psnr_value = 10 * log10(255^2 / mse); % Computing PSNR
fprintf('PSNR: %.2f dB\n', psnr_value); % Displaying PSNR
