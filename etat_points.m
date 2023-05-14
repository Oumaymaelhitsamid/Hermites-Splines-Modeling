function [matrice] = etat_point(noeuds, etape, abcisse, ordonnee)
    switch etape
        case 'ajouter'
            matrice = ajouter_point(noeuds, abcisse, ordonnee);
        case 'supprimer' 
            matrice = supprimer_point(noeuds, abcisse, ordonnee);
        case 'modifier'
            matrice = modifier_point(noeuds, abcisse, ordonnee);
    end
  
function [nouveau_matrice] = ajouter_point(points, abcisse_ajoutee, ordonnee_ajoutee)
    nouveau_matrice = points(:, :);
    nouveau_matrice(1, size(points, 2)+1) = abcisse_ajoutee;
    nouveau_matrice(2, size(points, 2)+1) = ordonnee_ajoutee;   
    

function [nouveau_matrice] = modifier_point(points, abcisse_nouveau, ordonnee_nouveau)
    if isempty(points)
        nouveau_matrice = points;
        return
    end
    numero_point=point_proche(points, abcisse_nouveau, ordonnee_nouveau)
    nouveau_matrice = points(:, :);
    nouveau_matrice(1, numero_point) = abcisse_nouveau;
    nouveau_matrice(2, numero_point) = ordonnee_nouveau;
    
function [ nouveau_matrice ] = supprimer_point(points, abcisse_supprimer, ordonnee_supprimer)
    if isempty(points)
        nouveau_matrice = points;
        return
    end
    numero_point =point_proche(points, abcisse_supprimer, ordonnee_supprimer) ;
    nouveau_matrice = zeros(2, size(points, 2) - 1);
    for k = 1:numero_point-1
       nouveau_matrice(:, k) = points(:, k);
    end
    for k = numero_point:size(points, 2)-1
       nouveau_matrice(:, k) = points(:, k+1);
    end

   
    
    