% EXAMEN UAVES 
% PROFESOR: DR HERMAN CASTANEDA
% Problema 1

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

A = zeros(12);
B = zeros(12,4);
C = zeros(4,12);

A(1,2) = 1; A(2,9) = g; A(3,4) = 1; A(4,7) = -g;
A(5,6) = 1; A(7,8) = 1; A(9,10) = 1; A(11,12) = 1;
B(6,1) = 1/m; B(8,2) = 1/Ixx; B(10,3) = 1/Iyy; B(12,4) = 1/Izz;
C(1,1) = 1; C(2,3) = 1; C(3,5) = 1; C(4,11) = 1;

w1 = sqrt((m*g)/(4*kt));
w2 = w1;
w3 = w1;
w4 = w1;

x_bar = [0;0;0;0;2;0;0;0;0;0;0;0];
u_bar = [w1;w2;w3;w4];

% P = [-0.1,-0.1,-0.1,-0.5,-0.5,-0.5,-10,-1,-10,-1,-15,-15];
P = [-11,-11,-9,-9,-7,-7,-8,-4,-15,-15,-3,-3];
% ---------------------------------------------------------

Cctr = [B, A*B, (A.^2)*B,(A.^3)*B,(A.^4)*B,(A.^5)*B,(A.^6)*B,(A.^7)*B,(A.^8)*B,(A.^9)*B,(A.^10)*B,(A.^11)*B];
r = rank(Cctr);

K = place(A,B,P);

k_bar = (C* (-A+B*K)^(-1)*B)^(-1);


mdl = "Herman_Problema1sim";
out = sim(mdl);

figure 
plot3(out.contr(:,1),out.contr(:,2),out.contr(:,3),LineWidth=2)
hold on 
plot3(out.orig(:,1),out.orig(:,2),out.orig(:,3),'--',LineWidth=2)
xlabel('x')
ylabel('y')
zlabel('z')
grid on







