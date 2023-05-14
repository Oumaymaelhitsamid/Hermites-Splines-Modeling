  
function [] = dessin(donees, abcisse, axc)
    noeuds = donees.nodes;
    
    axes(abcisse)
    cla
    title('Interpolation')
    hold on
    
    axes(axc)
    
    cla
    title('graphe de courbure')
    hold on
    axis auto
    
    axes(abcisse)
    
    axis(abcisse, [0 10 0 10])
    
    if isempty(noeuds)
        return
    end
    
    if donees.draw_nodes
        render_nodes(abcisse, noeuds, 'k', 'o')
    end
    
    
    if donees.draw_aitken
        plot_neville(donees, abcisse, axc)
    end
    
    if donees.draw_c1
        render_c1(donees, abcisse, axc)
    end
    
    if donees.draw_c2
        render_c2(donees, abcisse, axc)
    end
    
    axis(abcisse, [0 10 0 10])
    

function [] = render_nodes(ax, nodes, color, symb)
    scatter(ax, nodes(1,:), nodes(2,:), strcat(color, symb));

function [] = render_c2(datas, ax, axc)
    nodes = datas.nodes;
    resolution = datas.resolution;
    style = datas.style_c2;
    draw_ctrl = datas.draw_control;
    ctrl_symb = datas.ctrl_symb;
    
    n = size(nodes, 2);
    if n < 2
        return
    end
    
    % Les points auxiliaires de l'interpolation
    aux = transpose(compute_aux(nodes));
    
    % Les points de la courbe interpolée
    curve_points = zeros(2, resolution);
    % Le paramètre global
    u = 0;
    % Le pas d'incrémentation du paramètre global u
    u_stepping = (n - 1) / resolution;
    
    k = -1;
    local_control = zeros(2, 4);
    for i=1:(resolution-1)
        new_k = floor(u) + 1;
        if k ~= new_k
            k = new_k;
            pk   = nodes(:, k);
            pkp1 = nodes(:, k+1);
            dk   = aux(:, k);
            dkp1 = aux(:, k+1);
            % On met à jour le polygone de contrôle local
            local_control = [pk (pk + dk/3) (pkp1 - dkp1/3) pkp1];
            if draw_ctrl
                render_nodes(ax, local_control, style, ctrl_symb);
            end
        end
        % Le paramètre local
        t = u - (k - 1);
        % Interpolation du polygone de contrôle local par De Casteljau
        curve_points(:, i) = eval_dc(local_control, t);
        % Incrémentation du paramètre global
        u = u + u_stepping;
    end
    
    curve_points(:, resolution) = nodes(:, n);
    %plot_curvature(axc, style, curve_points);
    %plot(ax, curve_points(1, :), curve_points(2, :), style, 'linewidth', 1);
    dessiner_tout(datas, ax, axc, style, curve_points)

% Détermine les points auxiliaires nécessaire
% à l'interpolation C^2 par la résolution du système linéaire 
% posé par la recherche d'une courbe C^2
% P : les N + 2 points (2, n)
% Ax = b
function [x] = compute_aux(P)
    P(:, 1);
    n = size(P, 2);
    A = full(gallery('tridiag', n, 1, 4, 1));
    A(1, 1) = 2;
    A(n, n) = 2;
    B = zeros(n, 2);
    B(1, :) = 3 * (P(:, 2) - P(:, 1));
    B(n, :) = 3 * (P(:, n) - P(:, n-1));
    for i = 2:n-1
        B(i, :) = 3 * (P(:, i+1) - P(:, i-1));
    end
    x = A\B;
    
% -- render spline C1 -----------------------------------------------------

function [] = render_c1(datas, ax, axc)
    nodes = datas.nodes;
    resolution = datas.resolution;
    style = datas.style_c1;
    tmode = datas.tangent_mode;
    tension = datas.tension;
    draw_ctrl = datas.draw_control;
    ctrl_symb = datas.ctrl_symb;
    
    
    n = size(nodes, 2);
    if n < 2
        return
    end
    
    switch tmode
        case 'triangulate'
            tangents = trian(nodes, tension);
        otherwise
            tangents = cardinal_splines(nodes, tension);
    end
    
    polygone = hermite(nodes, tangents);

    curve_points = zeros(2, resolution);
    stepping = (n - 1) / resolution;
    u = 0;
    k = -1;
    for i=1:(resolution-1)
        new_k = floor(u);
        if k ~= new_k
            k = new_k;
            local_poly = polygone(:, (k * 3 + 1):(k * 3 + 4));
            if draw_ctrl
                render_nodes(ax, local_poly, style, ctrl_symb);
            end
        end
        t = u - k;
        curve_points(:, i) = eval_dc(local_poly, t);
        u = u + stepping;
    end
    
    curve_points(:, resolution) = polygone(:, size(polygone, 2));
    dessiner_tout(datas, ax, axc, style, curve_points)

function [] = plot_neville(datas, ax, axc)
    matrice = zeros(2, datas.resolution);
    parameters = 0:1/(size(datas.nodes, 2)-1):1;
    for k=0:(datas.resolution - 1)
    % p = eval_aitken(datas.nodes, parameters, t);
        matrice(:, k + 1) = eval_aitken(datas.nodes, parameters, (k / (datas.resolution - 1)));
    end
    
    dessiner_tout(datas, ax, axc, datas.style_aitken, matrice)
    
    
function dessiner_tout(datas, ax, axc, style, curve_points)
    curvature = courbure(axc, style, curve_points);
    plot(ax, curve_points(1, :), curve_points(2, :), style, 'linewidth', 1);
    
    
    
        
    