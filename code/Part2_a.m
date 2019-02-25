%% Part 2 a)
% A rectangular highly resistive box is included. Sigma, voltage ,
% electrical fied and current density plots are included.

nx = 100;
ny = 1.5 * nx; % Since we want the region to be a rectangle and ratio is 3/2

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



for x = 1:nx
    
    for y = 1:ny
        
        n = y + (x-1)*ny;
        nRx = y + (x)*ny;
        nLx = y + (x-2)*ny;
        nRy = y + 1 + (x-1)*ny;
        nLy = y - 1 + (x-1)*ny;
        
        if x == 1
            
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;
            
        elseif x == nx
            
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
            
        elseif y == 1
            
            G(n, nRx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nLx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nRy) = (sM(x, y+1) + sM(x,y))/2;
            G(n, n) = -(G(n,nRx)+G(n,nLx)+G(n,nRy));
            
        elseif y == ny
            
            G(n, nRx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nLx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nLy) = (sM(x, y-1) + sM(x,y))/2;
            G(n, n) = -(G(n,nRx)+G(n,nLx)+G(n,nLy));
            
        else
            
            G(n, nRx) = (sM(x+1, y) + sM(x,y))/2;
            G(n, nLx) = (sM(x-1, y) + sM(x,y))/2;
            G(n, nRy) = (sM(x, y+1) + sM(x,y))/2;
            G(n, nLy) = (sM(x, y-1) + sM(x,y))/2;
            G(n, n) = -(G(n,nRx)+G(n,nLx)+G(n,nRy)+G(n,nLy));
            
        end
    end
end

% sigma(x,y)
figure(1);
surf(sM);
xlabel("x");
ylabel("y");
zlabel("sigma");
axis tight;
view([40 30]);
title("Sigma along x and y");

%V(x,y)

V = G\B';
m = zeros(ny,nx,1);


for i = 1:nx
    for j=1:ny
        n = j + (i-1)* ny ;
        m(j,i) = V(n);
    end
end

figure(2)
surf(m);
title("Voltage plot")
xlabel("x")
ylabel("y")
zlabel("Voltage")
view(130,30);
title("Voltage plot with boxes")

%% Electric Field
% $E = -\nabla V$

[Ex,Ey] = gradient(m);
figure(3);
surf(-Ex) % negative gradient
xlabel("x")
ylabel("y")
zlabel("Electric Field ");
title("Electric field in x direction")
view([50 30]);
axis tight

figure(4);
surf(-Ey);
xlabel("x")
ylabel("y")
zlabel("Electric Field");
title("Electric field in y direction");
view([50 30]);
axis tight;

%% Electric Density
% Since  $J = \sigma * E$
Jx = sM' .* Ex;
Jy = sM' .* Ey;

J = sqrt(Jx.^2 + Jy.^2);

figure(5)
surf(J);
axis tight
xlabel("x")
ylabel("y")
zlabel("Current Densitys")
view([40 30]);
title("Curent Density plot")


