
%% Part 2 b)
% We want to increase the mesh sizes and see how the current changes with
% respect to it.

clear
clc
for mSize = 10:10:100
    
    nx = 100;
    ny = 1.5 * mSize; % Since we want the region to be a rectangle and ratio is 3/2
    
    G = sparse(mSize*ny); % the equations
    B = zeros(1,mSize*ny);
    
    sM = zeros (ny,mSize); % sigma matrix
    
    %the two contacts
    box = [mSize*2/5 mSize*3/5 ny*2/5 ny*3/5];
    
    for i = 1:mSize
        
        for j = 1:ny
            
            n = j + (i-1)*ny;
            
            if i == 1
                G(n, :) = 0;
                G(n, n) = 1;
                B(n) = 1;
                
            elseif i == mSize
                G(n, :) = 0;
                G(n, n) = 1;
                B(n) = 0;
                
            elseif j == 1
                
                if i > box(1) && i < box(2)
                    G(n, n) = -3;
                    G(n, n+1) = 0.01;
                    G(n, n+ny) = 0.01;
                    G(n, n-ny) = 0.01;
                    
                else
                    
                    G(n, n) = -3;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                    
                end
                
            elseif j == ny
                
                if i > box(1) && i < box(2)
                    
                    G(n, n) = -3;
                    G(n, n+1) = 0.01;
                    G(n, n+ny) = 0.01;
                    G(n, n-ny) = 0.01;
                    
                else
                    
                    G(n, n) = -3;
                    G(n, n+1) = 1;
                    G(n, n+ny) = 1;
                    G(n, n-ny) = 1;
                    
                end
                
            else
                
                if i > box(1) && i < box(2) && (j < box(3)||j > box(4))
                    
                    G(n, n) = -4;
                    G(n, n+1) = 0.01;
                    G(n, n-1) = 0.01;
                    G(n, n+ny) = 0.01;
                    G(n, n-ny) = 0.01;
                    
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
    
    for i = 1 : mSize
        
        for j = 1 : ny
            
            if i >= box(1) && i <= box(2)
                sM(j, i) = 0.01;
                
            else
                
                sM(j, i) = 1;
                
            end
            
            if i >= box(1) && i <= box(2) && j >= box(3) && j <= box(4)
                
                sM(j, i) = 1;
                
            end
        end
    end
    
    
    V = G\B';
    
    m = zeros(ny,mSize,1);
    
    for i = 1:mSize
        
        for j = 1:ny
            
            n = j + (i-1)*ny;
            m(j,i) = V(n);
            
        end
    end
    
    [Ex,Ey] = gradient(m);
    
    Jx = sM .* Ex;
    Jy = sM .* Ey;
    
    J = sqrt(Jx.^2 + Jy.^2);
    
    figure(1)
    hold on
    
    if mSize == 10
        
        curr = sum(J, 2);
        currSum = sum(curr);
        currTemp = currSum;
        plot([mSize, mSize], [currTemp, currSum])
        
    end
    if mSize > 10
        
        currTemp = currSum;
        curr = sum(J, 2);
        currSum = sum(curr);
        plot([mSize-10, mSize], [currTemp, currSum])
        xlabel("Mesh Size")
        ylabel("Current Density")
        
    end
    
    title("Mesh Size vs Current Density")
    
end

%% Conclusion
% From the plot, it is concluded that the mesh size is proportional to the current density