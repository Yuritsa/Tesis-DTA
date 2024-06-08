% Parámetros del actuador
length_actuator = 100e-3; % Longitud total del actuador en metros
num_segments = 2; % Número de segmentos para discretizar el actuador
segment_length = length_actuator / num_segments;

% Deformación y curvatura (ejemplo)
epsilon = 0.5; % Elongación (adimensional)
kappa = pi / 10; % Curvatura (radianes por metro)

% Inicialización de la matriz de transformación homogénea global
T_global = eye(4);

% Vector para almacenar las posiciones globales de cada segmento
positions = zeros(num_segments + 1, 3);

% Transformación a lo largo del actuador
for i = 1:num_segments
    % Matriz de rotación para el segmento i
    R = [cos(kappa * segment_length) -sin(kappa * segment_length) 0;
         sin(kappa * segment_length)  cos(kappa * segment_length) 0;
         0 0 1];
     
    % Vector de traslación para el segmento i
    d = [epsilon * segment_length; 0; 0];
    
    % Matriz de transformación homogénea para el segmento i
    T = [R d; 0 0 0 1];
    
    % Actualizar la matriz de transformación global
    T_global = T_global * T;
    
    % Almacenar la posición global del extremo del segmento i
    positions(i+1, :) = T_global(1:3, 4)';
end

% Visualización de las posiciones
figure;
plot3(positions(:, 1), positions(:, 2), positions(:, 3), '-o', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Posiciones globales del actuador suave');
grid on;
axis equal;
xlim([-0.2 0.2]); % Ajustar los límites de los ejes para mejor visualización
ylim([-0.2 0.2]);
zlim([-0.2 0.2]);