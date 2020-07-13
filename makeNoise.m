clear all
a = zeros(2048);
b = zeros(2048);
for x = 1:2048 
    for y = 1:2048 
        a(x,y,1:3) = marble([x/8,y/16]); 
        b(x,y,1:3) = marble([x/4,y/8]);
    end
end
%imshow(sqrt(a(:,:,1:3).^2+b(:,:,1:3).^2)/sqrt(2))
%imshow((a(:,:,1:3)+b(:,:,1:3))/2)
% imshow(a(:,:,1:3))
% sharpR = a(:,:,1).^2;
% sharpG = a(:,:,2).^2;
% sharpB = a(:,:,3).^2;
% sharpR(a(:,:,1) > 0.5) = sqrt(sqrt(sharpR(a(:,:,1) > 0.5)));
% sharpB(a(:,:,3) < 0.6) = sharpB(a(:,:,3) < 0.6).^2;
% sharpA = a;
% sharpA(:,:,1) = sharpR;
% sharpA(:,:,2) = sharpR;
% sharpA(:,:,3) = sharpB;
% imshow(sharpA);

sharpR = a(:,:,1).^2;
sharpG = a(:,:,2).^2;
sharpB = a(:,:,3).^2;
sharpR(a(:,:,1) > 0.4) = sqrt(sqrt(sharpR(a(:,:,1) > 0.4)));
sharpB(a(:,:,1) > 0.4) = sharpB(a(:,:,1) > 0.4).^2;
sharpG(a(:,:,1) > 0.4) = sharpG(a(:,:,1) > 0.4).^2;
sharpA = a;
sharpA(:,:,1) = sharpR;
sharpA(:,:,2) = sharpB;
sharpA(:,:,3) = sharpB;
sharpHSV = rgb2hsv(sharpA);
%sharpHSV(:,:,2) = sqrt(sqrt(sharpHSV(:,:,2)));
%sharpHSV(:,:,3) = sqrt(sqrt(sharpHSV(:,:,3)));
sharpHSV(:,:,3) = 1;
sharpA = hsv2rgb(sharpHSV);
imshow(sharpA);



