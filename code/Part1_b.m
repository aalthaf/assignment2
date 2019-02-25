
%Althaf Ahamed , 100971479
% Part 1 b)


global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s�

nx = 50;
ny = 1.5 * nx % Since we want the region to be a rectangle

G = sparse(nx*ny, nx*ny); % the equations
B = sparse(nx*ny, 1);

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
            B(n) = 1;
        elseif j==1 % left side
           G(n,:) =0;
           G(n,n) = 1;
            
        elseif j==ny % right side
            G(n,:) = 0;
            G(n,n) = 1;
            
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
view(130,30)

% Analytical Solution using infinite series

x1 = linspace(-nx/2,nx/2, 50);
y1 = linspace(0,ny,ny);
[i,j] = meshgrid(x1,y1);

 a= ny
 b = nx/2
 voltage = sparse(ny,nx);

 for n = 1:2:600
    voltage = (voltage + (cosh(n*pi*i/a).*sin(n*pi*j/a))./(n*cosh(n*pi*b/a)));   
    figure(2)
    surf(x1,y1,(4/pi)*voltage)
    title("Voltage using the analytical method in 2D")
    xlabel("x")
    ylabel("y")
    zlabel("Voltage")
    axis tight
    view(-130,30);
    pause(0.01)     
    
end



