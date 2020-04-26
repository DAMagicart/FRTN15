function [J] = solveJacobianVector(x,u,h,Q,R)
%Try to solve the jacobian J(x,u) = int{||x||^2 + ||u||^2} with fmincon
%The function will return J = [u1(k), u2(k)] which is the optimal
%control law for u, Hu time steps forward in time.
Hp = length(x)/4;           %Prediction Horizon  
Hu = length(u)/2;           %Control Horizon 

%Jag vet inte värdet på A och B. Dessa fås från diskretiseringen!
A = eye(4);                %test - 4*4
B = ones(4,2);             %test - 4*1

%Constraints for the control signal u - Jag vet inte vad dessa ska va.
% Au = eye(2*Hu);
% Bu = ones(2*Hu,1);
u0 = zeros(2*Hu,1);
                
Mp = zeros(Hp*4, Hu*2);
Np = zeros(4*Hp, 4);
row = zeros(4, Hu*2);
b = (h*B);
a = (1+h*A);
row(1:4,1:2) = b;
for i = 1:Hp
    Mp(4*i-3:4*i,:) = row;
    Np(4*i-3:4*i,:) = a^i;
    row = circshift(row',2)';
    row(1:4,1:2) = (a^i)*b;
end
x = reshape(x, [4,Hp]);

Xk = (Mp*u)+(Np*x(:,1));     %Xk -> (Ekv. 16.40, Rolf Johansson)
Qmat = Q*eye(4*Hp);
Rmat = zeros(2*Hu, 2*Hu);
for k = 1:Hu
    Rmat(k,k) = R;
end
lb=zeros(2*Hu,1);
ub=zeros(2*Hu,1);
for i=1:Hu
    lb(2*i-1:2*i)=[-0.2; -Inf];
    ub(2*i-1:2*i)=[0.2, Inf];
end
Ju = @(uMin)[(Xk'*Qmat*Xk) + [uMin]'*Rmat*[uMin]];
J1 = fmincon(Ju, u0,[],[],[],[],lb,ub);
J = reshape(J1, [2,Hu])';
end