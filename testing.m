clc; clear; close all;

% Step 1: Read Image
img = imread('script_paper.jpg'); % Replace with your image
gray = rgb2gray(img);  % Convert to Grayscale

% Step 2: Apply Adaptive Thresholding (Binarization)
bw = imbinarize(gray, 'adaptive', 'ForegroundPolarity', 'dark', 'Sensitivity', 0.5);
bw = imcomplement(bw); % Invert for better processing

% Step 3: Remove Horizontal Lines
se = strel('line', 15, 0); % Create a horizontal structuring element
lines = imerode(bw, se);   % Detect lines
lines = imdilate(lines, se); % Thicken lines for better subtraction

% Subtract lines from original binarized image
textOnly = bw & ~lines;

% Step 4: Noise Reduction
textOnly = medfilt2(textOnly, [3 3]); % Median filter for small noise
textOnly = imopen(textOnly, strel('disk', 1)); % Morphological opening

% Step 5: Display Processed Image
figure;
subplot(1,3,1); imshow(img); title('Original Image');
subplot(1,3,2); imshow(bw); title('Binarized Image');
subplot(1,3,3); imshow(textOnly); title('Text After Line Removal');

% Step 6: OCR (Text Extraction)
ocrResults = ocr(textOnly, 'TextLayout', 'Block');
extractedText = ocrResults.Text;

% Step 7: Display Extracted Text
disp('Extracted Text:');
disp(extractedText);

% Optional: Save extracted text to a file
fid = fopen('extracted_text.txt', 'w');
fprintf(fid, '%s', extractedText);
fclose(fid);
