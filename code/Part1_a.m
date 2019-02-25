
%Althaf Ahamed , 100971479
% Part 1 a)


global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²

nx = 100;
ny = 1.5 * nx % Since we want the region to be a rectangle and ratio is 3/2

G = sparse(nx*ny, nx*ny); % the equations
B = zeros(nx*ny, 1);

for i= 1:nx
    for j= 1:ny
        n = j + (i-1) * ny;
        
        if i == 1
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = 1;
        elseif i==nx
            G(n,:) = 0;
            G(n,n) = 1;
           % B(n) = 0;
        elseif j==1 % top
            G(n,:) = 0;
            G(n,n) = -3;
            G(n,n+1) = 1;
            G(n, n + ny) = 1;
            G (n,n-ny) = 1;
            
        elseif j==ny % bottom
            G(n,:) = 0;
            G(n,n)= -3;
            G(n,n-1) =1;
            G(n,n+ny) = 1; 
            G(n-ny) = 1; 
            
        else
            G(n,n) = -4; % middle value
            G(n,n-1) = 1; % left side
            G(n,n+1) = 1; % right side
            G(n,n-ny) = 1 ;% first value
            G(n,n+ny) = 1 ; % last value
        end
        
        
    end
    
end

V = G\B;

m = zeros(nx,ny,1);


for i = 1:nx
    for j=1:ny
        n = j + (i-1)* ny ;
        m(i,j) = V(n);
    end
end

figure(1)
surf(m)
title("Voltage in 1D")
xlabel("x")
ylabel("y")
zlabel("Voltage")
view(-130,30)



