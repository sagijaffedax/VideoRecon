function x = turbulence(pos, pixel_size)
  x=0;
  scale = 2;
  while(scale>pixel_size)
      pos = pos/scale;
      x = x + perlin(pos(1),pos(2))*scale;
      scale = scale/2;
  end;
end