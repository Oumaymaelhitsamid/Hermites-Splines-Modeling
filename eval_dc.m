function [dc] = eval_dc(points, t)
    taille = size(points, 2);
    points_dc = ones(2, taille-1);
    
    
        
    if taille ~= 1 
        seq = 1:1:(taille-1);
        for i = seq
            points_dc(:,i) = t * points(:,i+1)+ (1-t) * points(:,i); 
        end
        dc = eval_dc(points_dc, t);
    else
        dc = points(:,1);

    end