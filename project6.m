% project 6
% -------------------------------------------------------------------------
% Goal: 
% click 2 points on the map of NCTU where pedestrians can walk, and find a 
% smooth path between them.
% -------------------------------------------------------------------------
% instruction: 
% click 2 points by mouse, if you didn't click on the road where people can
% walk, you have to reclick. After clicking two acceptable points, it will
% show the shortest route on the screen.
% -------------------------------------------------------------------------

[I, cmap] = imread('NCTU01(v1).gif','frames','all');
colormap(cmap);
X = size(I,1);
Y = size(I,2);
linecolor = 1;

% adjust the size of figure. (this's according to my labptop.)
set(gcf, 'position', [300, 50, 1000, 720]); 

% show the image
image(I)
hold on;

 while true 
    % record the location of every determined node in advance.
    node_imformation = true;
    if node_imformation
        node_x = [294.8548, 297.5430, 295.3925, 219.0484, 296.4677,...
                  295.9301, 297.0054, 297.5430, 236.2527, 171.1989,...
                  351.8441, 349.6935, 350.7688, 357.2204, 354.5323,...
                  336.7903, 324.4247, 364.7473, 398.6183, 420.1237,...
                  406.1452, 407.2204, 407.7581, 377.6505, 407.7581,...
                  402.3817, 399.6935, 400.7688, 473.8871, 467.9731,...
                  467.9731, 443.2419, 451.3264, 483.5645, 480.8763,...
                  482.4892, 463.1344, 481.9516, 464.7473, 511.5215,...
                  515.8226, 510.9839, 494.3172, 496.4677, 533.5645,...
                  512.5968, 484.6398, 491.0914, 536.7903, 547.5430,...
                  563.1344, 569.0484, 544.3172, 527.6505, 529.8011,...
                  570.6613, 528.7258, 572.8118, 592.1667, 575.5000,...
                  595.9301, 602.9194, 577.1129, 597.5430, 613.6720,...
                  676.5753, 712.5968, 696.4677, 682.4892, 663.6720,...
                  643.7796, 642.1667, 632.4892, 618.5108, 592.7043,...
                  561.5215, 747.0054, 729.8011, 710.9839, 440.5826,...
                  450.5000, 571.9876, 576.1198];

        node_y = [165.6682, 201.5543, 247.5622, 308.2925, 306.4522,...
                  348.7795, 397.5478, 473.0007, 522.6891, 553.9745,...
                  165.6682, 200.6342, 250.3226, 304.6119, 347.8593,...
                  397.5478, 529.1302, 566.8567, 164.7480, 208.9156,...
                  231.9195, 249.4025, 312.8933, 396.6276, 396.6276,...
                  473.0007, 542.0124, 582.4993, 173.9496, 234.6800,...
                  249.4025, 318.4143, 395.5783, 440.7952, 472.0805,...
                  501.5255, 586.1800, 583.4195, 628.5072, 629.4274,...
                  207.9954, 234.6800, 251.2428, 281.6080, 292.6499,...
                  309.2127, 323.9352, 365.3423, 366.2624, 401.2284,...
                  438.9548, 472.0805, 480.3619, 501.5255, 510.7271,...
                  499.6852, 583.4195, 312.8933, 312.8933, 345.0988,...
                  344.1787, 364.4221, 265.0452, 224.5582, 194.1931,...
                  199.7140, 242.0412, 319.3344, 348.7795, 378.2245,...
                  432.5137, 466.5596, 508.8868, 542.0124, 564.0962,...
                  580.6590, 349.6996, 403.9889, 460.1185, 274.8999,...
                  360.1410, 391.7473, 415.6914];
    end

    % set the adjacancy of each pair of nodes in advance.
    % set by using notepad and python code.
    s = sparse(83, 83);
    sparse_imformation = true;
    if sparse_imformation
        s(1,2)=1; s(1,11)=1; s(2,1)=1; s(2,3)=1; s(2,12)=1; 
        s(3,2)=1; s(3,5)=1; s(3,13)=1; s(4,5)=1; s(5,3)=1;        
        s(5,4)=1; s(5,6)=1; s(5,14)=1; s(6,5)=1; s(6,7)=1;        
        s(6,15)=1; s(7,6)=1; s(7,8)=1; s(7,16)=1; s(8,7)=1; 
        s(8,9)=1; s(8,17)=1; s(9,8)=1; s(9,10)=1; s(10,9)=1; 
        s(11,1)=1; s(11,12)=1; s(11,19)=1; s(12,2)=1; s(12,11)=1; 
        s(12,13)=1; s(13,3)=1; s(13,12)=1; s(13,22)=1; s(14,5)=1; 
        s(14,15)=1; s(14,23)=1; s(15,6)=1; s(15,14)=1; s(15,24)=1; 
        s(16,7)=1; s(16,24)=1; s(17,8)=1; s(17,18)=1; s(18,17)=1; 
        s(18,27)=1; s(18,28)=1; s(19,11)=1; s(19,20)=1; s(19,29)=1; 
        s(20,19)=1; s(20,21)=1; s(20,29)=1; s(21,20)=1; s(21,22)=1; 
        s(21,30)=1; s(22,13)=1; s(22,21)=1; s(22,31)=1; s(22,80)=1; 
        s(23,14)=1; s(23,25)=1; s(23,32)=1; s(24,15)=1; s(24,16)=1; 
        s(24,25)=1; s(24,26)=1; s(25,23)=1; s(25,24)=1; s(25,26)=1; 
        s(25,33)=1; s(26,24)=1; s(26,25)=1; s(26,27)=1; s(26,35)=1; 
        s(27,26)=1; s(27,18)=1; s(27,28)=1; s(28,18)=1; s(28,27)=1; 
        s(28,37)=1; s(29,19)=1; s(29,20)=1; s(29,41)=1; s(30,21)=1; 
        s(30,31)=1; s(30,42)=1; s(31,30)=1; s(31,43)=1; s(32,23)=1; 
        s(32,47)=1; s(32,80)=1; s(32,81)=1; s(33,25)=1; s(33,34)=1; 
        s(33,48)=1; s(33,81)=1; s(34,33)=1; s(34,35)=1; s(34,48)=1; 
        s(34,51)=1; s(35,26)=1; s(35,34)=1; s(35,36)=1; s(36,35)=1; 
        s(36,38)=1; s(36,54)=1; s(37,28)=1; s(37,38)=1; s(37,39)=1; 
        s(38,36)=1; s(38,37)=1; s(38,57)=1; s(39,37)=1; s(39,40)=1; 
        s(40,39)=1; s(41,29)=1; s(41,42)=1; s(41,64)=1; s(42,30)=1; 
        s(42,41)=1; s(43,31)=1; s(43,44)=1; s(44,43)=1; s(44,45)=1; 
        s(45,44)=1; s(45,46)=1; s(45,63)=1; s(46,45)=1; s(46,47)=1; 
        s(46,58)=1; s(47,32)=1; s(47,46)=1; s(47,48)=1; s(47,81)=1; 
        s(48,33)=1; s(48,34)=1; s(48,47)=1; s(48,49)=1; s(48,81)=1; 
        s(49,48)=1; s(49,50)=1; s(49,60)=1; s(50,49)=1; s(50,51)=1; 
        s(50,82)=1; s(51,34)=1; s(51,50)=1; s(51,52)=1; s(51,83)=1; 
        s(52,51)=1; s(52,53)=1; s(52,56)=1; s(53,52)=1; s(53,54)=1; 
        s(54,36)=1; s(54,53)=1; s(54,55)=1; s(55,54)=1; s(55,56)=1; 
        s(55,57)=1; s(56,52)=1; s(56,55)=1; s(56,73)=1; s(57,38)=1; 
        s(57,55)=1; s(57,76)=1; s(58,46)=1; s(58,59)=1; s(58,60)=1; 
        s(59,61)=1; s(59,63)=1; s(59,68)=1; s(60,49)=1; s(60,58)=1; 
        s(60,61)=1; s(61,59)=1; s(61,60)=1; s(61,62)=1; s(62,61)=1; 
        s(62,70)=1; s(62,82)=1; s(63,45)=1; s(63,59)=1; s(63,64)=1; 
        s(64,41)=1; s(64,63)=1; s(64,65)=1; s(65,64)=1; s(65,66)=1; 
        s(66,65)=1; s(66,67)=1; s(67,66)=1; s(67,68)=1; s(68,59)=1;
        s(68,67)=1; s(68,69)=1; s(69,68)=1; s(69,70)=1; s(69,77)=1;
        s(70,62)=1; s(70,69)=1; s(70,71)=1; s(70,78)=1; s(71,70)=1;
        s(71,72)=1; s(71,79)=1; s(71,83)=1; s(72,71)=1; s(72,73)=1;
        s(73,56)=1; s(73,72)=1; s(73,74)=1; s(74,73)=1; s(74,75)=1;
        s(75,74)=1; s(75,76)=1; s(76,57)=1; s(76,75)=1; s(77,69)=1;
        s(77,78)=1; s(78,70)=1; s(78,77)=1; s(78,79)=1; s(79,71)=1;
        s(79,78)=1; s(80,22)=1; s(80,32)=1; s(81,32)=1; s(81,33)=1;
        s(81,47)=1; s(81,48)=1; s(82,50)=1; s(82,62)=1; s(82,83)=1;
        s(83,51)=1; s(83,71)=1; s(83,82)=1;
    end

    % transform to real distance relation
    for ii = 1:83
        for jj = 1:83
            if s(ii, jj) == 1     % if two nodes is adjacent, s is set to be their distance.
                dis2 = (round(node_x(jj))-round(node_x(ii)))^2 + ...
                       (round(node_y(jj))-round(node_y(ii)))^2;
                s(ii, jj) = sqrt(dis2);
            elseif s(ii, jj) == 0 % otherwise, s is set to be 9999.
                s(ii, jj) = 9999;
            end
        end
    end
 
    u = zeros(1,2);
    cnt = 0;
    while cnt < 2   % After getting 2 acceptable nodes, break the loop.
        [gx, gy, button] = ginput(1);
        if button == 3
            break;
        end

        % find the nearest node to the ginput.
        min_dis = 1000000;
        for jj = 1:83
            dis2 = (node_x(jj)-gx)^2 + (node_y(jj)-gy)^2;

            % The location of node should satisfy 2 conditions:
            %     1.the ginput should in the ball of one of the nodes.
            %     2.their distance is the nearest so far.
            % Then it's the "nearest" node so far.
            if sqrt(dis2) <= 40 && sqrt(dis2) < min_dis 
                min_dis = sqrt(dis2);     % update the shortest distance
                nearest = jj;             % update the nearest node number.
            end
        end

        % at least one acceptable node.
        % and the second node is not the first node.       
        if min_dis ~= 1000000 && nearest ~= u(1)  
            cnt = cnt + 1;
            plot(node_x(nearest), node_y(nearest), 'd', 'MarkerSize',8);
            u(cnt) = nearest;
        end
    end
    % ------------------------------------------------------------------------------------------------------
    % initialization
    A = u(1); % starting point
    B = u(2); % ending point               
    D = 10000 * ones(83, 1);          % record the "currently" shortest distance from A to the other points.
    D(A) = 9999;                      % set D(A) = 9999   
    final_D = 10000 * ones(83, 1);    % record the "final" shortest distance from A to the other points.
    predecessor = A * ones(83, 1);    % record the predecessor node of each node.
    % ------------------------------------------------------------------------------------------------------
    for ii = 1:83
        if s(A, ii) ~= 9999
            D(ii) = s(A, ii);
            predecessor(ii) = A;
        end
    end

    [closest_distance, closest_index] = min(D);
    final_D(closest_index) = closest_distance;
    D(closest_index) = 9999;

    while any(D-9999) % if all D are 9999, then break the loop. 

        Current = closest_index;
        for ii = 1:83

            % "ii is the neighbor of Current"  
            % "ii isn't "A" or "points already chosen". 
            if s(Current, ii) ~= 9999 && D(ii) ~= 9999

                % update D & predecessor of ii
                [D(ii), choose] = min([D(ii), final_D(Current) + s(Current, ii)]);
                if choose == 2
                    predecessor(ii) = Current;
                end
            end
        end
        [closest_distance, closest_index] = min(D);  % get the current minimum D in every loop.
        final_D(closest_index) = closest_distance;   % we can ensure that it's the minimum distance of that node.
        D(closest_index) = 9999;                     % take it out of the queue. (change its D to 9999)
    end

    % ================ DRAWING PART ================ %
    X = [];
    Y = []; 
    X = [X, node_x(B)];
    Y = [Y, node_y(B)];
    num = 1;
    while true
        index = predecessor(B);
        X = [X, node_x(index)];
        Y = [Y, node_y(index)];
        num = num + 1;
        B = index;
        if B == A
            break;
        end
    end

    % find the "nearest" polynomial.
    pick_x = []; 
    pick_y = []; 
    for ii = 1:num
        pick_x = [pick_x, X(ii)]; % origin nodes
        pick_y = [pick_y, Y(ii)];
        if ii == num
            break
        end
        % add some nodes (use to find polynomial) 
        for jj = 1:19 % strengthen the corner part (add more points, make it more realistic)
            pick_x = [pick_x, (X(ii)*(100-jj) + X(ii+1)*jj)/100];
            pick_y = [pick_y, (Y(ii)*(100-jj) + Y(ii+1)*jj)/100];
        end
        for jj = 20:2:80 % uniform middle part
            pick_x = [pick_x, (X(ii)*(100-jj) + X(ii+1)*jj)/100];
            pick_y = [pick_y, (Y(ii)*(100-jj) + Y(ii+1)*jj)/100];
        end
        for jj = 81:99 % strengthen the corner part (add more points, make it more realistic)
            pick_x = [pick_x, (X(ii)*(100-jj) + X(ii+1)*jj)/100];
            pick_y = [pick_y, (Y(ii)*(100-jj) + Y(ii+1)*jj)/100];
        end
    end
    n = size(pick_x, 2);          % the number of total nodes
    d = 20;                       % default degree = 20 (too big would have problems)
    t = linspace(1, n, 100); 
    px = polyfit(1:n, pick_x, d); % find the "nearest" polynomial in x direction.
    py = polyfit(1:n, pick_y, d); % find the "nearest" polynomial in y direction.
    fx = polyval(px, t);
    fy = polyval(py, t);
    color = ['k', 'r', 'm', 'b', 'c', 'y', 'g', 'w'];
    choosecolor = ['-', color(linecolor)];
    plot(fx, fy, choosecolor, 'LineWidth', 2.5);  % plot the parameric curve.
%     hold off;
    
    [gx, gy, button] = ginput(1);
    if button == 3     % quit the program
        break;
    elseif button == 1 % use again!
        linecolor = rem(linecolor + 1, 8); % change color
%         clf;
        continue;
    end
end