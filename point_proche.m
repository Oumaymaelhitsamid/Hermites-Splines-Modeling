
% donne le plus proche point du click
function [ min_i ] = point_proche(points,abcisse_clik,ordonnee_clik)
    p = [abcisse_clik; ordonnee_clik];
    n = size(points,2);
    min_dist = distance(points(:,1), p);
    min_i = 1;

    for i = 2:n
       dist = distance(points(:,i), p);
       if dist < min_dist
          min_dist = dist;
          min_i = i;
       end
    end 

function [dist] = distance(p, q)
    dist = sqrt((p(1) - q(1))^2 + (p(2) - q(2))^2);