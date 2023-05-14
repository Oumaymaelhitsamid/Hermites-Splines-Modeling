
function [m] = trian(matrice, c)
    
    m = ones(2, size(matrice,2));
    
    if size(matrice, 2) < 3
        disp('ajouter des points')
        return
    end
        
    for k=1:(size(matrice,2)-2)
        projection = projeter(matrice(:,k+1), matrice(:,k), matrice(:,k+2));
        m(:, k) = (1 - c) * ((matrice(:,k+1) + matrice(:,k+1) - projection) - matrice(:,k));
    end
    
    if size(matrice, 2) > 3
        indice = size(matrice,2)-1
    else 
        indice = size(matrice,2)
    end
    
    for k=indice:size(matrice,2)
        projection_point = projeter(matrice(:,k-1), matrice(:,k-2), matrice(:,k));
        m(:, k) = (1 - c) * (matrice(:,k) - (matrice(:,k-1) + matrice(:,k-1) - projection_point));
    end
function [ProjPoint] = projeter(p, u, v)
    x  = [-p(1)*(v(1)-u(1)) - p(2)*(v(2)-u(2)); 
          u(1)*(v(2)-u(2))-u(2)*(v(1)-u(1)) ]; 
    y  = [v(1) - u(1), v(2) - u(2);
          u(2) - v(2), v(1) - u(1)];
    ProjPoint = -(y\x);
