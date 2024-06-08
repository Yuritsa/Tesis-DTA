%Este código fue desarrollado para la tesis de doctordado de 
% Yuritsa Páez, UPIITA IPN
% El código evalua el ángulo de la deformación del actuador suave en
% función del tiempo


% Propiedades del material Ecoflex 00-30
E = 125e3; % Módulo de Young en Pa
nu = 0.49; % Coeficiente de Poisson
densidad = 1.07e3; % Densidad en kg/m^3

% Geometría del actuador
largo_actuador = 100e-3; % Longitud en metros (100 mm)
ancho = 20e-3; % Anchura en metros (20 mm)
grosor = 5e-3; % Grosor en metros (5 mm)

% Propiedades de las cámaras de aire
num_camaras = 1;
largo_camaras = largo_actuador/ num_chambers;
presion_camara = 100e3; % Presión en Pa

% Tiempo de activación
tiempo_act = 30; % en segundos
tiempo_steps = 100; % número de pasos de tiempo para la simulación
time_vector = linspace(0, activation_time, time_steps);

% Deformación total especificada del actuador
total_deformacion = 80e-3; % Deformación total en metros (80 mm)

% Cálculo del radio de curvatura y ángulo de deformación
R = (largo_actuador^2 + 4 * total_deformacion^2) / (8 * total_deformacion);
s = largo_actuador + total_deformacion;

% Discretización del actuador en nodos para simulación
nodes = linspace(0, largo_actuador, 100);
deformacions = zeros(length(nodes), length(time_vector));
angles = zeros(1, length(time_vector));

% Cálculo de la deformación y el ángulo en cada instante de tiempo
for t = 1:length(time_vector)
    deformacion_t = total_deformacion * (time_vector(t) / tiempo_act); % Deformación proporcional al tiempo
    R_t = (largo_actuador^2 + 4 * deformacion_t^2) / (8 * deformacion_t);
    angle_t = (largo_actuador+ deformation_t) / R_t;
    angles(t) = angle_t;
    for i = 1:length(nodes)
        deformacions(i, t) = deformacion_t; % Deformación proporcional al tiempo
    end
end

% Visualización de la deformación y el ángulo en función del tiempo
figure;
subplot(2, 1, 1);
for t = 1:length(time_vector)
    plot(nodes, deformacions(:, t), 'b', 'LineWidth', 2);
    xlabel('Posición a lo largo del actuador (m)');
    ylabel('Deformación (m)');
    title(['Deformación a lo largo del actuador suave a t = ', num2str(time_vector(t)), ' s']);
    grid on;
    pause(0.1); % Pausa para animación
end

subplot(2, 1, 2);
plot(time_vector, angles, 'r', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Ángulo de deformación (rad)');
title('Ángulo de deformación del actuador suave en función del tiempo');
grid on;