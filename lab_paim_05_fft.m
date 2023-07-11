clc
clear
close all

%% Carga de la imagen y conversión a uint8

A = imread("originales/lab05.png");
A = im2gray(A);
R = double(A);

figure
imshow(R, [])

%% Calculo de FFT

R_fft  = fft2(R);
R_fft_shift = fftshift(R_fft);

% Cálculo de la magnitud del espectro
S_abs = abs(R_fft_shift);

figure
imshow(S_abs, []);
title("Espectro - sin aplicar transformación logarítmica");

figure
imshow(20*log10(S_abs+1), []);
title("Espectro - aplicando transformación logarítmica");

G = 20*log10(S_abs+1);


figure
surf(G, 'EdgeColor', 'none')

G_min = G - min(G, [], "all");
max_G = max(G_min, [], "all");
Gs = 255 .* (G_min ./ max_G);
Gs = uint8(Gs);

imwrite(Gs, "espectro.png")
%% Filtrado de la imagen

filtro = imread("ejemplo_filtro_prueba.png");
filtro = im2gray(filtro);
filtro = im2double(filtro);


figure
imshow(filtro, [])

figure
surf(filtro)

S_fft_shift = R_fft_shift .* filtro;
S_fft = ifftshift(S_fft_shift);
S = ifft2(S_fft);

figure
imshow(abs(S), [])

S_mog = abs(S);
S_gamma  = S_mog .^ 1.5;

figure

subplot (121)
imshow(S_gamma, []);
subplot (122)

hold on

imshow(filtro, []);

% figure
% imshow(R, [])



