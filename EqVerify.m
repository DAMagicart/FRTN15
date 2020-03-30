function [ddtheta, ddphi] = EqVerify(dtheta, dphi, theta, phi, tau)
%The equations are derived from Section 5 in "Modelling the Furuta Pendulum"
%Run "InitEqVerify.m" before running this one.

%Equation (24) - THESE NEED TO STAY WITHIN THE FUNCTION
scaling = ((alpha*beta - gamma^2 + (beta^2 + gamma^2)*sin(theta)^2)^-1); 
ddtheta = scaling*(beta*gamma*(sin(theta)^2 -1)*sin(theta)*dphi^2 - 2*(beta^2)*cos(theta)*sin(theta)*dphi*dtheta + beta*gamma*sin(theta)*dtheta^2);
ddphi = scaling*((beta*(alpha + beta*sin(theta)^2)*cos(theta)*sin(theta)*dphi^2)+(2*beta*gamma*(1-sin(theta)^2)*sin(theta)*dphi*dtheta)-(gamma^2*cos(theta)*sin(theta)*dtheta^2)+(delta*(alpha + beta*sin(theta)^2)*sin(theta))-(gamma*cos(theta)*tphi)+((alpha+beta*sin(theta)^2)*ttheta));
end
