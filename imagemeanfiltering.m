% Load the noisy image
noisy_img = imread('digital_images_week5_quizzes_noisy.jpg'); % change filename if needed

% Convert to double
noisy_double = double(noisy_img);

% Normalize to [0, 1]
noisy_norm = noisy_double / 255;

% Display image
imshow(noisy_norm);
title('Noisy Image');

% Perform 1-pass median filtering
filtered1 = medfilt2(noisy_norm, [3, 3]);

% Display the result
imshow(filtered1);
title('1-pass Median Filtered Image');

% Perform 2-pass median filtering
filtered2 = medfilt2(filtered1, [3, 3]);

% Display the result
imshow(filtered2);
title('2-pass Median Filtered Image');

% Load the noise-free image
clean_img = imread('digital_images_week5_quizzes_original.jpg'); % change filename if needed

% Convert to double and normalize
clean_norm = double(clean_img) / 255;

% Compute PSNR between clean and noisy image
psnr_noisy = psnr(noisy_norm, clean_norm);

% Display PSNR value
fprintf('PSNR between noisy and clean image: %.2f dB\n', psnr_noisy);

% Compute PSNR between clean and 1-pass filtered image
psnr_filtered1 = psnr(filtered1, clean_norm);

% Display PSNR
fprintf('PSNR between clean and 1-pass filtered image: %.2f dB\n', psnr_filtered1);

% Compute PSNR between clean image and 2-pass filtered image
psnr_filtered2 = psnr(filtered2, clean_norm);

% Display PSNR
fprintf('PSNR between clean and 2-pass filtered image: %.2f dB\n', psnr_filtered2);
