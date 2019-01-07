% measure of image complexity
% P. Machado and A. Cardoso, "Computing Aesthetics"
% in Advances in Artificial Intelligence, 14th Brazilian Symposium on Artificial Intelligence,
% pp. 219-228, 1998

% code from: Florian Hoenig
% Computational Aesthetics and Visual Preference - An Experimental Approach, 2006
%
% he used JPG quality factor quality = 50

% I don't think the method scales properly as image changes size

function IC = complexity(I, quality)

% convert to grayscale
if length(I(1,1,:)) > 1
	I = rgb2gray(I);
end

% write to lossy jpeg and read back in
imwrite(I, 'temp.jpg', 'jpeg', 'mode', 'lossy', 'quality', quality);
J = imread('temp.jpg');

% compute RMS_error
K = I-J;
L = double(K);
rms = sqrt(sumsqr(L(:))/length(L(:)));

% compute compression ratio
info = imfinfo('temp.jpg');
c = info.FileSize;
ratio = length(I(:))/c;

% image complexity
IC = rms / ratio;

delete('temp.jpg');
