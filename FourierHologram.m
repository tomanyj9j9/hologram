clear
%tmp = single(rgb2gray(imread('Image.png')));
tmp = single(zeros(256,256));
tmp(32,128)=1*exp(1i*pi/4);
tmp(64,128)=1*exp(1i*pi/2);

[BY,BX]=size(tmp);
Im = single(zeros(BY,BX));

%Im(1:BY/2,BX/4+1:BX/4*3)=imresize(tmp,[BY/2,BX/2]);
%r =exp(1i*2*pi*rand(BY,BX)); %ランダム位相
%Im = Im.*r;
Im=tmp;
figure();subplot(1,2,1);
imagesc(abs(tmp));title('元画像');
u1 = padarray(Im,[BY/2 BX/2],0);%ゼロパディング

H = fftshift(fft2(fftshift(u1)));%干渉縞
%LCD =H(BY/2+1:BY/2*3,BX/2+1:BX/2*3); %複素振幅ホログラム 

LCD =abs(2*real(H(BY/2+1:BY/2*3,BX/2+1:BX/2*3))); %振幅ホログラム 
LCD=LCD/max(max(LCD)); %0～1
%LCD = (0.5<LCD); %二値化
u2 = padarray(LCD,[BY/2 BX/2],0);
rec = fftshift(fft2(fftshift(u2)));
rec = rec(BY/2+1:BY/2*3,BX/2+1:BX/2*3);
rec = rec/max(max(rec));

subplot(1,2,2);
imagesc(abs(rec).^2); %光のエネルギー
title('再生像');