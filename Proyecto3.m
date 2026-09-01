%============================================
% Script: Proyecto 3
% Movimiento de los polos
% Función de Transferencia: G(s) = K / (T*s + 1)
% William Sanchez Ramirez 2018235622
%============================================

pkg load control

clc;
clear;
close all;

% Ingreso de los datos
polos = input("Ingrese los polos: ");
ceros = input("Ingrese los ceros: ");

% Creacion de la Funcion de Transferencia
num = poly(ceros);
den = poly(polos);
G = tf(num,den);
G

% Ecuacion caracteristica
disp("Denominador (ecuacion caracteristica original):");
disp(den);

% ROOT LOCUS
figure;               % Abre ventana grafica
rlocus(G);            % Calcula y dibuja las raices de la FT
grid on;              % Agrega una cuadricula al grafico
title("Root Locus");  % Titulo del grafico

% Ingresar nuevos polos
disp("Ingrese los nuevos polos deseados");
polos_nuevos = input("Polos nuevos: ");

% Nueva ecuacion caracteristica
ec_nueva = poly(polos_nuevos);
disp("Nueva ecuacion caracteristica:");
disp(ec_nueva);

% Compensador
numc = ec_nueva;
denc = den;
C = tf(numc,denc);
disp("Compensador obtenido:");
C

% Sistema arregglado
Gc = series(C,G);
disp("Sistema compensado:");
Gc

% Respuesta al escalon
figure;
step(Gc);
grid on;
title("Respuesta al Escalon del Sistema Compensado");
