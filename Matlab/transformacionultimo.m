%Yuritsa Páez
%Tesis de doctorado
%UPIITA,IPN

%Relación de las matriz de rotación y transformación
%a partir de la longitud del actuador y su deformación


L = 100; % Longitud inicial del actuador en mm
delta_L = 80; % Deformación en mm
L_final = L + delta_L; % Longitud final

% Número de segmentos
n_segments = 5;
segment_length = L_final / n_segments;

% Ángulo de curvatura por segmento 
theta = pi/4; % 45 grados


% Matriz de rotación en torno al eje Z para el ángulo theta
Rz = @(theta) [cos(theta) -sin(theta) 0;
               sin(theta) cos(theta) 0;
               0 0 1];

% Vector de traslación en X por el segmento elongado
d = [segment_length; 0; 0];

% Matriz de transformación homogénea para un segmento
T_segment = @(theta, d) [Rz(theta), d; 0 0 0 1];

% Matriz de transformación homogénea inicial (identidad)
T_total = eye(4);

% Posiciones iniciales y finales de los segmentos
positions = zeros(3, n_segments+1);

for i = 1:n_segments
    % Calcular la transformación del segmento actual
    T_current = T_segment(theta, d);
    
    % Multiplicar con la transformación total
    T_total = T_total * T_current;
    
    % Guardar la posición final del segmento actual
    positions(:, i+1) = T_total(1:3, 4);
end

% Plot de las posiciones de los segmentos
figure;
plot3(positions(1, :), positions(2, :), positions(3, :), 'o-');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Posiciones globales del actuador suave');
grid on;