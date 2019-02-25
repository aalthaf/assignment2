
%% Part 2 b
% This code compares the numerical solution and analytical solution for
% Laplace's equation




nx = 50;
ny = 1.5 * nx; % Since we want the region to be a rectangle

G = sparse(nx*ny, nx*ny); % the equations
B = sparse(1,nx*ny);

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

V = G\B';

m = zeros(nx,ny,1);


for i = 1:nx
    for j=1:ny
        n = j + (i-1)* ny ;
        m(i,j) = V(n);
    end
end

figure(1);
surf(m);
title("Voltage using the numerical method");
xlabel("x");
ylabel("y");
zlabel("Voltage");
view(130,30);

% Analytical Solution using infinite series

x1 = linspace(-nx/2,nx/2, 50);
y1 = linspace(0,ny,ny);
[i,j] = meshgrid(x1,y1);

a= ny;
b = nx/2;
voltage = sparse(ny,nx);

for n = 1:2:600
    voltage = (voltage + (cosh(n*pi*i/a).*sin(n*pi*j/a))./(n*cosh(n*pi*b/a)));
    figure(2);
    surf(x1,y1,(4/pi)*voltage);
    title("Voltage using the analytical method");
    xlabel("x");
    ylabel("y");
    zlabel("Voltage");
    axis tight;
    view(-130,30);
    pause(0.01);
    
end


%% Conclusion
% The analytical solution coverges to the numerical solution for a while.
% After 600 iterations, the analytical solution does not look similar to
% the numerical solution anymore.
%
% Comparing the analytical and numerical solution:
%
% The analytical solution can be used to calculate a solution quickly.
% However, sometimes the analytical solution fails to give the correct
% solution as they are simplistic models
%
% The numerical method can give the approximate answer. However, it uses many resources. 
% Also,you will have to accumulate some error in the final solution.
