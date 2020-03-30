%% Initiate Equation Verification
%The equations are derived from Section 5 in "Modelling the Furuta Pendulum"

%Given parameters - "competition.pdf"
l  = 75*10^-3;       %[m]      - Length of arm
r  = 43*10^-3;       %[m]      - Base radius
d  = 31.5*10^-3;     %[m]      - Length of pendulum
J  = 125*10^-6;      %[kgm^2]  - Base moment of inertia
g  = 9.8;            %[m/s^2]  - Gravity
Jc = 2.55*10^-6;     %[kgm^2]  - Moment of inertia of pendulum around c.o.m
m  = 5.44*10^-3;     %[kg]     - Mass of pendulum point mass
Jp = 7.95*10^-6;     %[kgm^2]  - Moment of inertia of pend around pivot

%Conditions/Constraints
%abs(tau_psi) < 0.2  %[Nm] ?

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

%Equation (16)
dLdphi = 0;
dLddphi = ((alpha + beta*sin(theta)^2)*dphi)+(gamma*cos(theta)*cos(dtheta));
dLdtheta = (beta*cos(theta)*sin(theta)*dphi^2)-(gamma*sin(theta)*dphi*dtheta)+(delta*sin(theta));
dLddtheta (gamma*cos(theta)*dphi) + (beta*dtheta);

%________Eq15 could possible be done in simulink
%I AM NOT SURE ABOUT THESE ONES!
ddtdLddphi = ?;     %I don't know what to do with these
ddtdLddtheta = ?;

%Equation (15) - partial derivatives of the Lagrangian
tphi    = ddtdLddphi - dLdphi;      %d/dt(d/dphi(L)) - d/dtph(L)
ttheta  = ddtdLddtheta - dLdtheta;  %d/dt(d/dtheta(L)) - d/dtheta(L)  
%________down here!_____________________________

%Equation (20)
D = [(alpha + beta*sin(theta)^2),(gamma*cos(theta));(gamma*cos(theta)),(beta)];
C = [(beta*cos(theta)*sin(theta)*dtheta),(beta*cos(theta)*sin(theta)*dphi - gamma*sin(theta)*dtheta);(-beta*cos(theta)*sin(theta)*dphi),(0)];

%Comments/Thoughts:
%Phi    = Angle of the arm around the centre
%Theta  = Angle of the pendulum

%% Verify the model
%The model is correct if the energy is conserved when the velocities are 0.
%i.e. : ddtheta=ddphi=0, when dtheta=dphi=0 & theta = pi, phi = ?

StatPoint1 = [0,0,0,0,0];  %[dtheta, dphi, theta, phi, tau]
StatPoint2 = [0,0,pi,0,0]; %[dtheta, dphi, theta, phi, tau]

%If the result are [0,0] the system is conservative
[ddtheta1, ddphi1] = EqVerify(StatPoint1)
[ddtheta2, ddphi2] = EqVerify(StatPoint2)

