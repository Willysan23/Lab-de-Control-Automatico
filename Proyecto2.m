%============================================
% Script: Proyecto 2
% Función de Transferencia: G(s) = K / (T*s + 1)
% William Sanchez Ramirez 2018235622
%============================================

pkg load control

% Limpiar los comandos
clc;
clear;
close all;

% Solicitar informacion al usuario
polos = input("Ingrese los polos entre corchetes [ ] : ");
ceros = input("Ingrese los ceros entre corchetes [ ] : ");

% Definir K como ganancia
K = 1;

% Construir la Funcion de Transferencia segun los ceros y polos
num = poly(ceros);
den = poly(polos);
G = tf(num, den);
disp("Funcion de transferencia G(s):");
G

% Obtener los coeficientes
n = length(den);
num_ext = [zeros(1,n-length(num)) num];
ec_car = den + K*num_ext;
disp("Coeficientes de la ecuacion caracteristica:");
disp(ec_car);

m = length(ec_car);
filas = m;
columnas = ceil(m/2);
R = zeros(filas,columnas);
R(1,:) = [ec_car(1:2:end), ...
zeros(1,columnas-length(ec_car(1:2:end)))];
R(2,:) = [ec_car(2:2:end), ...
zeros(1,columnas-length(ec_car(2:2:end)))];
for i = 3:filas
for j = 1:(columnas-1)
R(i,j) = ((R(i-1,1)*R(i-2,j+1)) - ...
(R(i-2,1)*R(i-1,j+1))) / R(i-1,1);
end
end

% Crear la tabla
disp("Tabla de Routh-Hurwitz:");
disp(R);

primera_columna = R(:,1);
if all(primera_columna > 0)
disp("El sistema es ESTABLE.");
else
disp("El sistema NO es estable.");
end

% Crear el grafico
figure;
rlocus(G);
grid on;
title("Lugar Geometrico de las Raices");
hold on;
plot(real(polos), imag(polos), "rx", "markersize", 10);
plot(real(ceros), imag(ceros), "go", "markersize", 10);
legend("Root Locus","Polos","Ceros");








