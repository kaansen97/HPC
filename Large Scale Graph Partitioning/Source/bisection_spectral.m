function [part1,part2] = bisection_spectral(A,xy,picture)
% bisection_spectral : Spectral partition of a graph.
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zuric
%
% [part1,part2] = bisection_spectral(A) returns a partition of the n vertices
%                 of A into two lists part1 and part2 according to the
%                 spectral bisection algorithm of Simon et al:
%                 Label the vertices with the components of the Fiedler vector
%                 (the second eigenvector of the Laplacian matrix) and partition
%                 them around the median value or 0.

n = size(A,1);
map = zeros(n,1);

% Steps
% 1. Construct the Laplacian.
G=graph(A);
A=adjacency(G);
D = diag(sum(A));
L = D - A;

% 2. Calculate its eigensdecomposition.
[eig_vec, ~]=eigs(L,2,0.00001);

% 3. Label the vertices with the components of the Fiedler vector.
u=eig_vec(:,2);
med = median(u);

% 4. Partition them around their median value, or 0.
for i=1:n
    if u(i)<med
        map(i)=1;
    end
end

part1=find(map==0);
part2=find(map==1);
if picture == 1
    gplotpart(A,xy,part2);
    title('Spectral bisection using the Fiedler Eigenvector');
end

end
