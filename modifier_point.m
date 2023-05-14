
function [nouveau_point] = modifier_point(points, abcisse_nouveau, ordonnee_nouveau)
    indice = point_proche(points, abcisse_nouveau, ordonnee_nouveau);
    nouveau_point = points(:, :);
    nouveau_point(1, indice) = abcisse_nouveau;
    nouveau_point(2, indice) = ordonnee_nouveau;