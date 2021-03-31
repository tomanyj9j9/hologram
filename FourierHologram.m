clear
tmp = single(rgb2gray(imread('image.png')));
%tmp = single(zeros(256,256));
%tmp(32,128)=1*exp(1i*pi/4);
%tmp(64,128)=1*exp(1i*pi/2);

[BY,BX]=size(tmp);
Im = single(zeros(BY,BX));

Im(1:BY/2,BX/4+1:BX/4*3)=imresize(tmp,[BY/2,BX/2]);
%r =exp(1i*2*pi*rand(BY,BX)); %ランダム位相
%Im = Im.*r;

%Im=tmp;
figure();subplot(1,2,1);
imagesc(abs(Im));title('元画像');
u1 = padarray(Im,[BY/2 BX/2],0);%ゼロパディング

Interference = fftshift(fft2(fftshift(u1)));%干渉縞
%Holo =Interference(BY/2+1:BY/2*3,BX/2+1:BX/2*3); %複素振幅ホログラム 

Holo =(2*real(Interference(BY/2+1:BY/2*3,BX/2+1:BX/2*3))); %振幅ホログラム 
%Holo = abs(Holo);
%Holo=Holo/max(max(Holo)); %0～1
%Holo = (0.5<Holo); %二値化

u2 = padarray(Holo,[BY/2 BX/2],0);
rec = fftshift(fft2(fftshift(u2)));
rec = rec(BY/2+1:BY/2*3,BX/2+1:BX/2*3);
rec = rec/max(max(rec));

subplot(1,2,2);
imagesc(abs(rec).^2); %光のエネルギー
title('再生像');