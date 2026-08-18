%============================================
% Script: Simulación del Sistema
% Función de Transferencia: G(s) = K / (T*s + 1)
% William Sanchez Ramirez 2018235622
%============================================

clear all;                   % Borra informacion en sistema (variables)
clc;                         % Limpia ventana comandos
close all;                   % Cierra todos los graficos/figuras

pkg load control;            % Necesario para FT en Octave

% Secuencia para solicitar valores y verificacion de valores aceptables
Kt = input ('Ingrese valor de Kt: ');
while Kt < 0
  disp('Valor invalido, el valor debe ser mayor a cero')
  Kt = input ('Ingrese valor de Kt: ');
end
Ra = input ('Ingrese valor de Ra: ');
while Ra < 0
  disp('Valor invalido, el valor debe ser mayor a cero')
  Ra = input ('Ingrese valor de Ra: ');
end
b = input ('Ingrese valor de b: ');
while b < 0
  disp('Valor invalido, el valor debe ser mayor a cero')
  b = input ('Ingrese valor de b: ');
end
Kb = input ('Ingrese valor de Kb: ');
while Kb < 0
  disp('Valor invalido, el valor debe ser mayor a cero')
  Kb = input ('Ingrese valor de Kb: ');
end
J = input ('Ingrese valor de J: ');
while J < 0
  disp('Valor invalido, el valor debe ser mayor a cero')
  J = input ('Ingrese valor de J: ');
end

% Definir valores de Funcion de Transferencia G(s)
Km = (Kt) / ((Ra*b) + (Kt*Kb))
T = (Ra*J) / ((Ra*b) + (Kt*Kb))
den = [T, 1]
G = tf (Km, den)

% Imprimir valor de la funcion de transferencia
disp('Función de Transferencia Obtenida G(s):');
G

% Definir tiempos de simulacion
t_final = T * 10;
t = 0:0.01:t_final;

% Calculo de la respuesta al escalon unitario
[y, t] = step (G, t)

% Graficar estos valores
figure('Name', 'Respuesta al Escalón');
plot(t, y, 'b-', 'LineWidth', 2);
grid on;
hold on;

% Ubicar datos en el graficos
% Valor final
line([0 t_final], [Km Km], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);

% Punto característico en t = T
y_T = 0.632 * Km;
plot(T, y_T, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
line([T T], [0 y_T], 'Color', 'k', 'LineStyle', ':');
line([0 T], [y_T y_T], 'Color', 'k', 'LineStyle', ':');

% Punto característico en t = 4T
t_asentamiento = 4 * T;
y_4T = 0.982 * Km;
plot(t_asentamiento, y_4T, 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm');

% Títulos y valores
title(['Respuesta al Escalón Unitario: G(s) = ', num2str(Km), ' / (', num2str(T), 's + 1)'], 'FontSize', 12);
xlabel('Tiempo (s)', 'FontSize', 11);
ylabel('Respuesta y(t)', 'FontSize', 11);

legend('Respuesta y(t)', ...
       ['Valor final (K = ', num2str(Km), ')'], ...
       ['t = T (63.2% K = ', num2str(y_T), ')'], ...
       ['t = 4T (Tiempo de asentamiento 2% = ', num2str(t_asentamiento), 's)'], ...
       'Location', 'southeast');

xlim([0 t_final]);
ylim([0 Km * 1.15]);
















