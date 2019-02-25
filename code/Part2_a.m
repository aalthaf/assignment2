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

G = sparse(nx*ny); % the equations
B = zeros(1,nx*ny);


sM = zeros (nx,ny);

box = [nx*2/5 nx*3/5 ny*2/5 ny*3/5];

% Rectangular region setup
for i = 1:nx
    
    for j = 1:ny
        
        
        if i > box(1) && i < box(2) && (j < box(3)||j > box(4))
            sM(i, j) = 0.01;
            
        else
            sM(i, j) = 1;
            
            
        end
    end
end


%Inside the Rectangule in the G matrix
for x = 1:nx
    
    for y = 1:ny
        
        n = y + (x-1)*ny;
        nposx = y + (x)*ny;
        nnegx = y + (x-2)*ny;
        nposy = y + 1 + (x-1)*ny;
        nnegy = y - 1 + (x-1)*ny;
        
        if x == 1
            
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;
            
        elseif x == nx
            
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
            
        elseif y == 1
            
            G(n, nposx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nnegx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nposy) = (sM(x, y+1) + sM(x,y))/2;
            G(n, n) = -(G(n,nposx)+G(n,nnegx)+G(n,nposy));
            
        elseif y == ny
            
            G(n, nposx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nnegx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nnegy) = (sM(x, y-1) + sM(x,y))/2;
            G(n, n) = -(G(n,nposx)+G(n,nnegx)+G(n,nnegy));
            
        else
            
            G(n, nposx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nnegx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nposy) = (sM(x, y+1) + sM(x,y))/2;
            G(n, nnegy) = (sM(x, y-1) + sM(x,y))/2;
            G(n, n) = -(G(n,nposx)+G(n,nnegx)+G(n,nposy)+G(n,nnegy));
            
        end
    end
end

% sigma(x,y)
figure(1)
surf(sM);
xlabel("x")
ylabel("y")
zlabel("sigma")
axis tight
view([40 30]);
title("Sigma along x and y")

%V(x,y)

V = G\B'
m = zeros(ny,nx,1);


for i = 1:nx
    for j=1:ny
        n = j + (i-1)* ny ;
        m(j,i) = V(n);
    end
end

figure(2)
surf(m)
title("Voltage plot")
xlabel("x")
ylabel("y")
zlabel("Voltage")
view(130,30)
title("Voltage plot with boxes")

%E(x,y) can be found using gradient function
[Ex,Ey] = gradient(m);
figure(3)
surf(-Ex)
xlabel("x")
ylabel("y")
zlabel("Electric Field ")
title("Electric field in x direction")
view([50 30]);
axis tight

figure(4)
surf(-Ey)
xlabel("x")
ylabel("y")
zlabel("Electric Field")
title("Electric field in y direction")
view([50 30]);
axis tight

% J = sigma * E
Jx = sM' .* Ex;
Jy = sM' .* Ey;

J = sqrt(Jx.^2 + Jy.^2)

figure(5)
surf(J)
axis tight
xlabel("x")
ylabel("y")
zlabel("Current Densitys")
view([40 30]);
title("Curent Density plot")


