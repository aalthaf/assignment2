
%% Part 2 d)
%
% We want to increase the sigma value and see how the current changes with
% respect to it


for s = 0.01:0.01:0.9
    
    nx = 50;
    ny = 1.5 * nx; % Since we want the region to be a rectangle and ratio is 3/2
    
    G = sparse(nx*ny); % the equations
    B = zeros(1,nx*ny);
    
    sM = zeros (ny,nx); % sigma matrix
    
    %the two contacts will become smaller with each iteration
    box = [nx*2/5 nx*3/5 ny*2/5 ny*3/5];
    
    for i = 1:nx
        
        for j = 1:ny
            
            n = j + (i-1)*ny;
            
            if i == 1
                G(n, :) = 0;
                G(n, n) = 1;
                B(n) = 1;
                
            elseif i == nx
                G(n, :) = 0;
                G(n, n) = 1;
                B(n) = 0;
                
            elseif j == 1
                
                if i > box(1) && i < box(2)
                    G(n, n) = -3;
                    G(n, n+1) = s;
                    G(n, n+ny) = s;
                    G(n, n-ny) = s;
                    
                else
                    
                    G(n, n) = -3;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                    
                end
                
            elseif j == ny
                
                if i > box(1) && i < box(2)
                    
                    G(n, n) = -3;
                    G(n, n+1) = s;
                    G(n, n+ny) = s;
                    G(n, n-ny) = s;
                    
                else
                    
                    G(n, n) = -3;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                    
                end
                
            else
                
                if i > box(1) && i < box(2) && (j < box(3)||j > box(4))
                    
                    G(n, n) = -4;
                    G(n, n+1) = s;
                    G(n, n-1) = s;
                    G(n, n+ny) = s;
                    G(n, n-ny) = s;
                    
                else
                    
                    G(n, n) = -4;
                    G(n, n+1) = 1;
                    G(n, n-1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                    
                end
            end
        end
    end
    
    for i = 1 : nx
        
        for j = 1 : ny
            
            if i >= box(1) && i <= box(2)
                sM(j, i) = s;
                
            else
                
                sM(j, i) = 1;
                
            end
            
            if i >= box(1) && i <= box(2) && j >= box(3) && j <= box(4)
                
                sM(j, i) = 1;
                
            end
        end
    end
    
    
    V = G\B';
    
    m = zeros(ny,nx,1);
    
    for i = 1:nx
        
        for j = 1:ny
            
            n = j + (i-1)*ny;
            m(j,i) = V(n);
            
        end
    end
    
    [Ex,Ey] = gradient(m);
    
    Jx = sM .* Ex;
    Jy = sM .* Ey;
    
    J = sqrt(Jx.^2 + Jy.^2);
    
    figure(1);
    hold on;
    
    if s == 0.01
        curr = sum(J, 2);
        currSum = sum(curr);
        currTemp = currSum;
        plot([s, s], [currTemp, currSum])
    end
    if s > 0.01
        currTemp = currSum;
        curr = sum(J, 2);
        currSum = sum(curr);
        plot([s-0.01, s], [currTemp, currSum])
        xlabel("Sigma");
        ylabel("Current Density");
    end
    title("Sigma vs Current Density");
    
end
%% Conclusion
% Naturally, when the sigma value increases, the current density increases
% since it is directly proportional