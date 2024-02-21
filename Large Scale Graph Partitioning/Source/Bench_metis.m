%function [cut_recursive,cut_kway] = Bench_metis(picture)
% Compare recursive bisection and direct k-way partitioning,
% as implemented in the Metis 5.0.2 library.

% Steps
% 1. Initialize the cases
% 2. Call metismex to
%     a) Recursively partition the graphs in 16 and 32 subsets.
%     b) Perform direct k-way partitioning of the graphs in 16 and 32 subsets.
% 3. Visualize the results for 32 partitions.

countries = {
"luxembourg_osm.mat";
"usroads.mat";
}

cntr = {
    "gr_adj.mat";
    "ch_adj.mat";
    "vn_adj.mat";
    "no_adj.mat";
    "ru_adj.mat";}

lst = {
    gr_adj;
    ch_adj;
    vn_adj;
    no_adj;
    ru_adj;}


rec_cut16 = zeros(7);

kway_cut16 = zeros(7);

rec_cut32 = zeros(7);

kway_cut32 = zeros(7);


for k=1:numel(countries)
    load(countries{k});
    W = Problem.A;
    coords = Problem.aux.coord;
    nparts = 16;
    [map_rn,edgecut] = metismex('PartGraphRecursive',W,nparts);
    [map_kway,edgecutkway] = metismex('PartGraphKway',W,nparts);
    
    

    rec_cut16(k) = edgecut;
    kway_cut16(k) = edgecutkway;


    nparts = 32;
    [~,edgecut] = metismex('PartGraphRecursive',W,nparts);
    [map,edgecutkway] = metismex('PartGraphKway',W,nparts);

    rec_cut32(k) = edgecut;
    kway_cut32(k) = edgecutkway;

     figure(k+5)
     gplotmap(W,coords,map_rn);
     title('rn 32 parts')
     figure(k+7)
     gplotmap(W,coords,map_kway);
     title('kway 32 parts')


end

for k=1:numel(cntr)
    load(cntr{k});
    W=sparse(lst{k});
    
    nparts = 16;
    [~,edgecut] = metismex('PartGraphRecursive',W,nparts);
    [map,edgecutkway] = metismex('PartGraphKway',W,nparts);
    
    rec_cut16(k+2) = edgecut;
    kway_cut16(k+2) = edgecutkway;


    nparts = 32;
    [~,edgecut] = metismex('PartGraphRecursive',W,nparts);
    [~,edgecutkway] = metismex('PartGraphKway',W,nparts);

    rec_cut32(k+2) = edgecut;
    kway_cut32(k+2) = edgecutkway;

end

load ru_adj.mat;
W=sparse(ru_adj);
nparts = 32;
load ru_coord.mat;
coords = ru_coord; 
[map_rn,edgecut] = metismex('PartGraphRecursive',W,nparts);
[map_kway,edgecutkway] = metismex('PartGraphKway',W,nparts);

figure(10)
gplotmap(W,coords,map_rn);
title('rn 32 parts')
figure(11)
gplotmap(W,coords,map_kway);
title('kway 32 parts')











