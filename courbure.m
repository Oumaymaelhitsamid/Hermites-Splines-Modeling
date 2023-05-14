
function [courbure] = courbure(position_courbe, couleur, points_courbe)
    nb_points = size(points_courbe, 2);
    courbure = ones(1, nb_points-2);
   for k = 2:(nb_points-1)
       % les 3 arêtes du triangle
       x = sqrt((points_courbe(1, k-1)-points_courbe(1, k))^2+(points_courbe(2, k-1)-points_courbe(2,k))^2); 
       y = sqrt((points_courbe(1, k)-points_courbe(1, k+1))^2+(points_courbe(2,k)-points_courbe(2,k+1))^2);
       z = sqrt((points_courbe(1, k+1)-points_courbe(1, k-1))^2+(points_courbe(2,k+1)-points_courbe(2, k-1))^2);
       s = (x+y+z)/2; 
       courbure(k-1) = 4*(sqrt(abs(s*(s-x)*(s-y)*(s-z))))/(x*y*z); 
     end
        
 
    %axe = 0:10/nb_points:10;
    axe = (1:nb_points-2);
    plot(position_courbe, axe, courbure , couleur, 'linewidth', 2)

