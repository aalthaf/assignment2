
%% Finite Difference Method
%% Question 1
% This code solves laplaces equation using the finite difference method.


nx = 100;
ny = 1.5 * nx; %Since we want the region to be a rectangle and ratio is 3/2

G = sparse(nx*ny, nx*ny); %the equations
B = zeros(1,nx*ny);

for i= 1:nx
    for j= 1:ny
        n = j + (i-1) * ny;
        
        if i == 1 % left
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = 1; 
        elseif i==nx % right
            G(n,:) = 0;
            G(n,n) = 1;
          
        elseif j==1 %top
            
            G(n,n) = -3;
            G(n,n+1) = 1;
            G(n, n + ny) = 1;
            G (n,n-ny) = 1;
            
        elseif j==ny %bottom
            
            G(n,n)= -3;
            G(n,n-1) =1;
            G(n,n+ny) = 1;
            G(n-ny) = 1;
            
        else
            G(n,n) = -4; %middle value
            G(n,n-1) = 1; %left side
            G(n,n+1) = 1; %right side
            G(n,n-ny) = 1 ;%first value
            G(n,n+ny) = 1 ; %last value
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
title("Voltage in 1D");
xlabel("x");
ylabel("y");
zlabel("Voltage");
view(-190,40);



