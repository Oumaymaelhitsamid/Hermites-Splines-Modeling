 
% renvoie le polygone de controle de Bezier (auterment dit les bi)
% associé au spline Hermite cubique passé en paramètre
% @param hermite : matrice de dimension (2, 2 * n) = [p0, m0, ..., pn, mn]
% @return : polygone de contrôle
function [controle] = hermite(matrice, m)
    degre = size(matrice, 2);
    taille = (degre - 1) * 3 + 1;
    controle = zeros(2, (degre - 1) * 3 + 1);
    for k=1:(degre-1)
        controle(:, (k - 1) * 3 + 1   ) = matrice(:, k); %b0
        controle(:, (k - 1) * 3 + 2) = matrice(:, k) + m(:, k    ) / 3;
        controle(:, (k - 1) * 3 + 3) = matrice(:, k + 1) - m(:, k + 1) / 3;
        
    end
    controle(:, taille) = matrice(:, degre);
    