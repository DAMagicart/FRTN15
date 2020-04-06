%Given parameters - "competition.pdf"
l  = 75*10^-3;       %[m]      - Length of arm
r  = 43*10^-3;       %[m]      - Base radius
d  = 31.5*10^-3;     %[m]      - Length of pendulum
J  = 125*10^-6;      %[kgm^2]  - Base moment of inertia
g  = 9.8;            %[m/s^2]  - Gravity
Jc = 2.55*10^-6;     %[kgm^2]  - Moment of inertia of pendulum around c.o.m
m  = 5.44*10^-3;     %[kg]     - Mass of pendulum point mass
Jp = 7.95*10^-6;     %[kgm^2]  - Moment of inertia of pend around pivot

%Still unknown - Try to guess these as a first step
ma = 10*10^-3;       %[kg] - Mass of arm       - Try 10g
mp = 5*10^-3;        %[kg] - Mass of pendulum  - Try 5g

%Given in "competition.pdf"
J  = J;      %Inertia of rotating arm
M  = m;      %Mass of pendulum-ball
la = l;      %Length of arm
lp = d;      %Length of pendulum
g  = g;      %Gravity

%Equation (17)
alpha   = J + (M + (1/3)*ma + mp)*la^2;
beta    = (M + (1/3)*mp)*lp^2;
gamma   = (M + (1/2)*mp)*la*lp;
delta   = (M + (1/2)*mp)*g*lp;

%% Testa att ska symbolic vectors
syms theta
syms phi
q = [phi; theta];
syms dtheta;
syms dphi;
dq = [dphi; dtheta];

D = [(alpha + beta*sin(theta)^2),(gamma*cos(theta));(gamma*cos(theta)),(beta)];
C = [(beta*cos(theta)*sin(theta)*dtheta),(beta*cos(theta)*sin(theta)*dphi - gamma*sin(theta)*dtheta);(-beta*cos(theta)*sin(theta)*dphi),(0)];

%% Skriv in dina värden för A-, och B-matrisen


