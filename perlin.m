% function n = perlin(x, y, z)
% % noise(x, y, z) generates (I believe) 3 dimensional noise. To use, iterate
% % through your array and generate each value with a call this function.
% % Note that it is very slow.
% % 
% % Based Ken Perlin's "Improved Noise" in 2001, or 2002, or something.
% 
% % The unit cube which contains this point
% uX = mod(floor(x), 256);
% uY = mod(floor(y), 256);
% uZ = mod(floor(z), 256);
% 
% % Find relative x, y, z of point in cube
% x =x- floor(x);
% y =y- floor(y);
% z =z- floor(z);
% 
% % The mysterious "fade" function
% fade = @(t) t * t * t * (t * (t * 6 - 15) + 10);
% 
% % Compute fade curved for each of x, y, z
% u = fade(x);
% v = fade(y);
% w = fade(z);
% 
% % Hash coordinates of the 8 cube corners
% p_half = randi(256, 256, 1) - 1;
% p = [p_half, p_half];
% 
% a = p(1+uX) + uY;
% aa = p(1+a) + uZ;
% ab = p(1+a + 1) + uZ;
% 
% b = p(1+uX + 1) + uY;
% ba = p(1+b) + uZ;
% bb = p(1+b + 1) + uZ;
% 
% % "Lerp" is a shorter, more confusing name for "linear interpolation"
% lerp = @(t, a, b) a + t * (b - a);
% 
% % This is how he gets the gradient
%     function g = grad(hash, x, y, z)
%         %Convert the low 4 bits of hash code into 12 gradient directions
%         h = mod(hash, 16);
% 
%         % 50% chance for u to be on x or y
%         if h < 8
%             u_comp = x;
%         else
%             u_comp = y;
%         end
% 
%         % 50% chance to reverse either component
%         if mod(h, 2) == 0
%             u_comp = -u_comp;
%         end
% 
%         % 12.5% chance for v to be on x, 25% chance to be on y, 62.5% chance for z
%         if (h == 12 || h == 14)
%             v_comp = x;
%         elseif (h < 4)
%             v_comp = y;
%         else
%             v_comp = z;
%         end
% 
%         % 50% chance to reverse either component
%         if mod(h/2, 2) == 0
%             v_comp = -v_comp;
%         end
% 
%         g = u_comp + v_comp;
%     end
% 
% % And add blended results from 8 corners of cube
% n = lerp(w, lerp(v, lerp(u, grad(p(1+aa), x, y, z), ...
%     grad(p(1+ba), x - 1, y, z)), ...
%     lerp(u, grad(p(1+ab), x, y - 1, z), ...
%     grad(p(1+bb), x - 1, y - 1, z))), ...
%     lerp(v, lerp(u, grad(p(1+aa + 1), x, y, z - 1), ...
%     grad(p(1+ba + 1), x - 1, y, z - 1)), ...
%     lerp(u, grad(p(1+ab + 1), x, y - 1, z - 1), ...
%     grad(p(1+bb + 1), x - 1, y - 1, z - 1))));
% end

%figure; imagesc(im); colormap jet;

function n = perlin_noise(x,y,clearIm)

persistent im;
persistent X;
persistent Y;
if ( isempty(im) || (nargin > 2 && clearIm))
    im = zeros(2048,2048);
    [X,Y] = meshgrid(1:2048);
    [n, m] = size(im);
    i = 0;
    w = sqrt(n*m);
    
    while w > 3
        i = i + 1;
        d = interp2(randn(ceil((n-1)/(2^(i-1))+1),ceil((m-1)/(2^(i-1))+1)), i-1, 'spline');
        im = im + i * d(1:n, 1:m);
        w = w - ceil(w/2 - 1);
    end
    im = (im-(min(min(im))))/(max(max(im))-min(min(im)));
end
  square = zeros(2,2);
  square(1,:) = [mod(floor(x),1024) mod(floor(y),1024)]+1;
  square(2,:) = square(1,:)+1;
  alpha = x+1 - square(1,1);
  beta = y+1 - square(1,2);
  lowY = im(square(1,1),square(1,2))*(1-alpha)+im(square(2,1),square(1,2))*alpha;
  highY = im(square(1,1),square(2,2))*(1-alpha)+im(square(2,1),square(2,2))*alpha;
  n = lowY*(1-beta)+highY*beta;
end
    