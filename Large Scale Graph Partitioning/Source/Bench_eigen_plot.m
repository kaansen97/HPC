% Visualize information from the eigenspectrum of the graph Laplacian
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

% add necessary paths
addpaths_GP;

% Graphical output at bisection level
picture = 0;

cases = {
    'airfoil1.mat';
    '3elt.mat';
    'barth4.mat';
    'mesh3e1.mat';
    'crack.mat';
    };

nc = length(cases);
for c = 1:nc
    
    load(cases{c});
    

% Initialize the cases
W      = Problem.A;
coords = Problem.aux.coord;

% Steps
% 1. Construct the graph Laplacian of the graph in question.
G=graph(W);
A=adjacency(G);
D = diag(sum(A));
L = D - A;
% 2. Compute eigenvectors associated with the smallest eigenvalues.
[eig_vec, ~]=eigs(L,2,'smallestabs');
% 3. Perform spectral bisection.
[part1,part2] = bisection_spectral(W,coords,0)
% 4. Visualize:
%   i.   The first and second eigenvectors.
figure(1)
u1 = eig_vec(:,1);
u2 = eig_vec(:,2);
plot(1:length(u1),u1)
hold on
plot(1:length(u2),u2,'o')
%   ii.  The second eigenvector projected on the coordinate system space of graphs.
figure(2)


gplotpart(W,coords,part1,"white","black","red");
view(160,10)
hold on
sz = 90*ones(size(W,1),1);
hold on 
scatter3(coords(:,1),coords(:,2), u2*20,sz,u2,".");
colormap jet;
colorbar;
%   iii. The spectral bi-partitioning results using the spectral coordinates of each graph.
[eig_vec, eig_val]=eigs(L,3,'smallestabs');

figure(4)
u3 = eig_vec(:,3);
plot(1:length(u3),u3)
coords = [-u2,-u3];
gplotpart(W,coords,part1)

end