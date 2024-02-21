%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

function [part1,part2] = bisection_inertial(A,xy,picture)
% bisection_inertial : Inertial partition of a graph.
%
% [p1,p2] = bisection_inertial(A,xy) returns a list of the vertices on one side of a partition
%     obtained by bisection with a line or plane normal to a moment of inertia
%     of the vertices, considered as points in Euclidean space.
%     Input A is the adjacency matrix of the mesh (used only for the picture!);
%     each row of xy is the coordinates of a point in d-space.
%
% bisection_inertial(A,xy,1) also draws a picture.


% disp(' ');
% disp(' HPC Lab at USI:   ');
% disp(' Implement inertial bisection');
% disp(' ');


% Steps
% 1. Calculate the center of mass.
% 2. Construct the matrix M.
%  (Consult the pdf of the assignment for the creation of M) 
% 3. Calculate the smallest eigenvector of M.  
% 4. Find the line L on which the center of mass lies.
% 5. Partition the points around the line L.
%   (you may use the function partition.m)

% same as proj3 in NC of last year
p = mean(xy);
Sxx = sum((xy(:,1) - p(1)).^2);
Syy = sum((xy(:,2) - p(2)).^2);
Sxy = sum((xy(:,1) - p(1)).*(xy(:,2) - p(2)));
M = [Sxx, Sxy ; Sxy, Syy];
[u,~] = eigs(M,2,0.00001);
u = u(:,1);
u = [u(2), -u(1)];
[part1,part2] = partition(xy, u);

if picture == 1
    gplotpart(A,xy,part1);
    title('Inertial bisection using the Fiedler Eigenvector');
end

% <<<< Dummy implementation to generate a partitioning
% n   = size(A,1);
% map = zeros(n,1);
% map(1:round((n/2)))     = 0; 
% map((round((n/2))+1):n) = 1;
% 
% 
% [part1,part2] = other(map);
% 
% if picture == 1
%     gplotpart(A,xy,part1);
%     title('Inertial bisection (dummy) using the Fiedler Eigenvector');
% end
% Dummy implementation to generate a partitioning >>>>

end
