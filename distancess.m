function d=distancess(x1,x2)
% numm=abs(x1).'*abs(x2);
% den=((x1'*x1).*(x2'*x2)).^0.5;
% rt=numm/den;
d=abs(rms(x1)-rms(x2));
end