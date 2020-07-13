function rgb = marble(pos)
  rgb = zeros(1,3);
  x = sin((pos(2)+3.0*turbulence(pos,0.25))*pi+3.0*turbulence(pos,0.125)*pi+3.0*turbulence(pos,0.5)+3.0*turbulence(pos,1)*pi);
  % x = sin((pos(2)+3.0*perlin(pos(1),pos(2)))*pi);
  x = sqrt(x+1)*.7071;
  rgb(2)=50/255+.8*x;
  x = sqrt(x);
  rgb(1)= 255/255 - (255-30)/255*x;
  rgb(3)= 50/255 + .8*x;
end