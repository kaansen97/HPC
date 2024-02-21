% Benchmark for recursively partitioning meshes, based on various
% bisection approaches
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich



% add necessary paths
addpaths_GP;
nlevels_a = 3;
nlevels_b = 4;

fprintf('       *********************************************\n')
fprintf('       ***  Recursive graph bisection benchmark  ***\n');
fprintf('       *********************************************\n')

% load cases
cases = {
    'airfoil1.mat';
    'netz4504_dual.mat';
    'stufe.mat';
    '3elt.mat';
    'barth4.mat';
    'ukerbe1.mat';
    'crack.mat';
    };

nc = length(cases);
maxlen = 0;
for c = 1:nc
    if length(cases{c}) > maxlen
        maxlen = length(cases{c});
    end
end

for c = 1:nc
    fprintf('.');
    sparse_matrices(c) = load(cases{c});
end


fprintf('\n\n Report Cases         Nodes     Edges\n');
fprintf(repmat('-', 1, 40));
fprintf('\n');
for c = 1:nc
    spacers  = repmat('.', 1, maxlen+3-length(cases{c}));
    [params] = Initialize_case(sparse_matrices(c));
    fprintf('%s %s %10d %10d\n', cases{c}, spacers,params.numberOfVertices,params.numberOfEdges);
end

%% Create results table
fprintf('\n%7s %16s %20s %16s %16s\n','Bisection','Spectral','Metis 5.0.2','Coordinate','Inertial');
fprintf('%10s %10d %6d %10d %6d %10d %6d %10d %6d\n','Partitions',8,16,8,16,8,16,8,16);
fprintf(repmat('-', 1, 100));
fprintf('\n');


for c = 1:nc
    spacers = repmat('.', 1, maxlen+3-length(cases{c}));
    fprintf('%s %s', cases{c}, spacers);
    sparse_matrix = load(cases{c});
    

    % Recursively bisect the loaded graphs in 8 and 16 subgraphs.
    % Steps
    % 1. Initialize the problem
    
    [params] = Initialize_case(sparse_matrices(c));
    W = params.Adj;
    coords = params.coords;
    % 2. Recursive routines
    % i. Spectral    
    [map_s8,sepij_s8,sepA_s8]= rec_bisection('bisection_spectral',3,W,coords,0);
    [map_s16,sepij_s16,sepA_s16]= rec_bisection('bisection_spectral',4,W,coords,0);
    
    % ii. Metis
    [map_metis8,sepij_metis8,sepA_metis8] = rec_bisection('bisection_metis',3,W,coords,0);
    [map_metis16,sepij_metis16,sepA_metis16] = rec_bisection('bisection_metis',4,W,coords,0);

    % iii. Coordinate  
    [map_coord8,sepij_coord8,sepA_coord8] = rec_bisection('bisection_coordinate',3,W,coords,0);
    [map_coord16,sepij_coord16,sepA_coord16] = rec_bisection('bisection_coordinate',4,W,coords,0);

    % iv. Inertial
    [map_iner8,sepij_iner8,sepA_iner8] = rec_bisection('bisection_inertial',3,W,coords,0);
    [map_iner16,sepij_iner16,sepA_iner16] = rec_bisection('bisection_inertial',4,W,coords,0);

    % 3. Calculate number of cut edges
    [cut_s8] = cutsize(W,map_s8);
    [cut_s16] = cutsize(W,map_s16);

    [cut_coord8] = cutsize(W,map_coord8); 
    [cut_coord16] = cutsize(W,map_coord16); 

    [cut_metis8] = cutsize(W,map_metis8);
    [cut_metis16] = cutsize(W,map_metis16);

    [cut_iner8] = cutsize(W,map_iner8);
    [cut_iner16] = cutsize(W,map_iner16);

    % 4. Visualize the partitioning result
    figure(1)
    gplotmap(W,coords,map_s8)
    title('spectral 8 part')

    figure(2)
    gplotmap(W,coords,map_s16)
    title('spectral 16 part')
    
    figure(3)
    gplotmap(W,coords,map_coord8) 
    title('coordiante bisection 8 part')
    
    figure(4)
    gplotmap(W,coords,map_coord16) 
    title('coordiante bisection 16 part')

    figure(5)
    gplotmap(W,coords,map_metis8)
    title('metis bisection 8 part')

    figure(6)
    gplotmap(W,coords,map_metis16)
    title('metis bisection 16 part')

    figure(7)
    gplotmap(W,coords,map_iner8)
    title('inertial bisection 8 part')

    figure(8)
    gplotmap(W,coords,map_iner16)
    title('inertial bisection 16 part')

    fprintf('%6d %6d %10d %6d %10d %6d %10d %6d\n',cut_s8,cut_s16,cut_metis8,cut_metis16,cut_coord8,cut_coord16,cut_iner8,cut_iner16);
    
end
