% cardinal_splines
% calcul les tangentes par la méthode de cardinal splines
function [m] = cardinal_splines(matrice, c)
    
    n = size(matrice, 2);
    m = zeros(2, n); 
 
    for i=2:(n-1)
        m(:, i) = (1 - c) * (matrice(:, i + 1) - matrice(:, i - 1)) / 2;
        
    end
    %m(:, 1) = [0 0];
   % m(:, n) = [0 0];
        
    
        
     