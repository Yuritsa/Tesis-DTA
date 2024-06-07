%Este código es para calcular la deformación de un actuador suave
%elaborado con un elastomero que es el Ecoflex OO-30. 
%El calculo de la deformación de este actuador se empleo para el 
%desarrollo de la tesis de doctorado de Yuritsa Páez, UPIITA IPN.

% Propiedades del material Ecoflex 00-30
E = 125e3; % Módulo de Young en Pa
nu = 0.49; % Coeficiente de Poisson
G = E / (2 * (1 + nu)); % Módulo de corte

% Geometría del actuador
largo_actuador = 100e-3; % Longitud en metros (100 mm)
ancho = 20e-3; % Anchura en metros (20 mm)
grosor = 5e-3; % Grosor en metros (5 mm)

% Propiedades de las cámaras de aire
num_camaras = 1;
longitud_camara = largo_actuador / num_camaras;
presion_camara = 100e3; % Presión en Pa

% Tiempo de activación
tiempo_act = 30; % en segundos
tiempo_steps = 100; % número de pasos de tiempo para la simulación
time_vector = linspace(0, tiempo_act, tiempo_steps);

% Inicialización de variables para tensiones y deformaciones
deformacion = zeros(length(time_vector), 1);
tensions = zeros(length(time_vector), 1);

% Cálculo de tensiones y deformaciones
for t = 1:length(time_vector)
    % Presión aplicada en cada cámara a lo largo del tiempo
    pressure_t = presion_camara * (time_vector(t) / tiempo_act);
    force_t = pressure_t * (ancho * grosor);
    
    % Cálculo de la tensión normal en la dirección x (longitudinal)
    sigma_x = force_t / (ancho * grosor);
    
    % Cálculo de la deformación en la dirección x (longitudinal) usando la ley de Hooke generalizada
    epsilon_x = (1/E) * (sigma_x - nu * (0 + 0)); % Tensiones en y y z son cero en este modelo simplificado
    
    % Guardar valores
    tensions(t) = sigma_x;
    deformacion(t) = epsilon_x * largo_actuador; % Deformación total en metros
end

% Visualización de tensiones y deformaciones en función del tiempo
figure;
subplot(2, 1, 1);
plot(time_vector, tensions, 'b', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Tensión (Pa)');
title('Tensión en el actuador suave en función del tiempo');
grid on;

subplot(2, 1, 2);
plot(time_vector, deformacion, 'r', 'LineWidth', 2);
xlabel('Tiempo (s)');
ylabel('Deformación (m)');
title('Deformación en el actuador suave en función del tiempo');
grid on;