% EXAMEN UAVES 
% PROFESOR: DR HERMAN CASTANEDA
% Problema 2

% Daniel Castañón A01284991

% CONDICIONES
% ---------------------------------------------------------
g = 9.81;
m = 0.068;
Ixx = 0.0000686;
Iyy = 0.000092;
Izz = 0.0001366;
kt = 0.0107;
phase = pi/2;

w1 = sqrt((m*g)/(4*kt));
w2 = w1;
w3 = w1;
w4 = w1;
x_bar = [0;0;0;0;2;0;0;0;0;0;0;0];
u_bar = [w1;w2;w3;w4];

A = zeros(12);
B = zeros(12,4);
C = zeros(6,12);

A(1,2) = 1; A(2,9) = g; A(3,4) = 1; A(4,7) = -g;
A(5,6) = 1; A(7,8) = 1; A(9,10) = 1; A(11,12) = 1;
B(6,1) = 1/m; B(8,2) = 1/Ixx; B(10,3) = 1/Iyy; B(12,4) = 1/Izz;
C(1,1) = 1; C(2,3) = 1; C(3,5) = 1; C(4,7) = 1; C(5,9) = 1; C(6,11) = 1;
% ---------------------------------------------------------



% PARA EL CONTROL 
% ---------------------------------------------------------
Cctrl = zeros(4,12);
Cctrl(1,1) = 1; Cctrl(2,3) = 1; Cctrl(3,5) = 1; Cctrl(4,11) = 1;

Pctrl = [-11,-11,-9,-9,-7,-7,-8,-4,-15,-15,-3,-3];

K = place(A,B,Pctrl);

k_bar = (Cctrl * (-A+B*K)^(-1)*B)^(-1);
% ---------------------------------------------------------



% PARA FILTRO KALMAN
% ---------------------------------------------------------
vk = 0.13;
wk = [0.35;0.35;0.35;0.4;0.4;0.4];

G = [1;1;1;1;1;1;1;1;1;1;1;1];

T = 0.01;

Ad = expm(A*T);
Bd = pinv(A) * (Ad - eye(12,12)) * B;
Gd = pinv(A) * (Ad - eye(12,12)) * G;

t = 0:T:70; 
x0 = [0;0;0;0;2;0;0;0;0;0;0;0]; 

x = x0;
y = C*x0;

xh = [0;0;0;0;1.5;0;0;0;0;0;0;0];
xp = xh;

P = eye(12,12);
% ---------------------------------------------------------



% PLOTTEAR 
% ---------------------------------------------------------
mdl = "Herman_Problema2sim";
out = sim(mdl);

figure 
plot3(out.orig(:,1),out.orig(:,2),out.orig(:,3),'--',LineWidth=2)
hold on 
plot3(out.contr(:,1),out.contr(:,2),out.contr(:,3),LineWidth=2)
xlabel('x')
ylabel('y')
zlabel('z')
grid on


figure 
plot3(out.orig(:,1),out.orig(:,2),out.orig(:,3),'--',LineWidth=2)
hold on 
plot3(out.kalman(:,1),out.kalman(:,3),out.kalman(:,5),LineWidth=2)
xlabel('x')
ylabel('y')
zlabel('z')
grid on
% ---------------------------------------------------------





% for n = 1:length(t)-1
%     x(:,n+1) = (Ad * x(:,n)) + (Bd * u(:,n)) + (Gd * sqrt(vk) * randn);
%     y(:,n+1) = (C * x(:,n+1)) + sqrt(wk) * randn;
%     
%     xp(:,n+1) = (Ad * xh(:,n)) + (Bd * u(:,n));
%     L = (Ad*P*Ad' + Gd*vk*Gd') * C' * pinv(C * (Ad*P*Ad' + Gd*vk*Gd') * C' + diag(wk));
%     xh(:,n+1) = xp(:,n+1) + L * (y(:,n+1) - C * xp(:,n+1));
%     P = (eye(12,12) - L*C) * (Ad*P*Ad' + Gd*diag(vk)*Gd') * (eye(12,12) - L*C)' + L*diag(wk)*L';
% end

% figure
% plot(t,x)
% 
% figure 
% plot(t,x - xp)


