% nodes_remove
% @param mat : matrice de taille (2, n)
% @param X   : l'abscisse du point à supprimer
% @param Y   : l'ordonnée du point à supprimer
% @return m  : la nouvelle matrice
function [ nouveau_matrice ] = supprimer_point(points, abcisse_suprimee, ordonnee_suprimee)
    numero_point = point_proche(points, abcisse_suprimee, ordonnee_suprimee);
    nouveau_matrice = ones(2, size(points, 2) - 1);
    for k = 1:numero_point-1
       nouveau_matrice(:, k) = points(:, k);
    end
    for k = numero_point:size(points, 2)-1
       nouveau_matrice(:, k) = points(:, k+1);
    end

   
