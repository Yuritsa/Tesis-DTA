clear , clc , close all

%t es time, x es x

load('ZB2_2.mat','PROMEDIOZ_B22');
load('Time.mat','Tiempo_Segundos');

% figure;
% plot(Tiempo_Segundos,PROMEDIOX_B21)
% hold on;

%t=table2array(readtable('Pruebas24oct2023_todas.csv','Range','B1:B10802'));
%x=table2array(readtable('Pruebas24oct2023_todas.csv','Range','AG1:AG10802'));

% 
 n=16;
[p,S,mu] = polyfit(Tiempo_Segundos,PROMEDIOZ_B22,n);
S.normr = norm(p);
% % 
f = polyval(p,Tiempo_Segundos,S,mu); 
r=roots(p);
plot(Tiempo_Segundos,PROMEDIOZ_B22,'m-',Tiempo_Segundos,f,'g-','LineWidth',2);
% 
title('Desaccionamiento en Z para el cuerpo rígido 2 (Polinomio n=16)');
xlabel('Tiempo (s)');
ylabel('Unidades en mm')
% 
legend('Data','linear fit') 
grid on
hold on
% s=sprintf(['y = (%.01f) x^2^0 + (%.01f) x^1^9 + (%.01f) x^1^8 + (%.01f) x^1^7 + (%.01f) x^1^6 + (%.01f) x^1^5  + (%.01f) x^1^4 + (%.01f) x^1^3 + (%.01f) x^1^2 + (%.01f) x^1^1 + (%.01f) x^1^0 + (%.01f) x^9 + (%.01f) x^8 + (%.01f) x^7 + ' ...
%     '(%.01f) x^6 + (%.01f) x^5 + (%.01f) x^4 + (%.01f) x^3 + (%.01f) x^2 + (%.01f) x + (%.01f)'],p(1),p(2),p(3),p(4),p(5),p(6),p(7),p(8),p(9),p(10),p(11),p(12),p(13),p(14),p(15),p(16),p(17),p(18),p(19),p(20),p(21));
% text(1,-152.377,s)
% 
% 
% 
