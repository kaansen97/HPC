% Script to load .csv lists of adjacency matrices and the corresponding 
% coordinates. 
% The resulting graphs should be visualized and saved in a .csv file.
%
% D.P & O.S for the "HPC Course" at USI and
%                   "HPC Lab for CSE" at ETH Zurich

addpaths_GP;

% Steps
% 1. Load the .csv files
help csvread

% 2. Construct the adjaceny matrix (NxN). There are multiple ways
%    to do so.
help accumarray
help sparse

% 3. Visualize the resulting graphs
help gplotg

% 4. Save the resulting graphs
help save

% Example of the desired graph format for CH
% load Swiss_graph.mat
% W      = CH_adj;
% coords = CH_coords;   
% whos
% figure;
% gplotg(W,coords);

%%%%%% Norway %%%%%%%%%

no_coord=readtable('Datasets/Countries_Meshes/csv/NO-9935-pts.csv');

no_adj=readtable('Datasets/Countries_Meshes/csv/NO-9935-adj.csv', 'ReadVariableNames',false);    

no_adj=table2array(no_adj);

no_coord=table2array(no_coord);
save('Datasets/Countries_mat/no_coord.mat', 'no_coord');
N = graph(no_adj(:,1), no_adj(:,2) );
N = adjacency(N);
N = full(N); 
no_adj = N;
save('Datasets/Countries_mat/no_adj.mat', 'no_adj');

W = N;
coords = no_coord;  
whos
figure;
gplotg(W,coords);

%%%%%% Vietnam %%%%%%%%%

vn_coord=readtable('Datasets/Countries_Meshes/csv/VN-4031-pts.csv', 'ReadVariableNames',false);

vn_adj=readtable('Datasets/Countries_Meshes/csv/VN-4031-adj.csv');

vn_adj=table2array(vn_adj);

vn_coord=table2array(vn_coord);
save('Datasets/Countries_mat/vn_coord.mat', 'vn_coord');
V = graph( vn_adj(:,1), vn_adj(:,2) );
V= adjacency(V);
V= full(V); 
vn_adj= V;
save('Datasets/Countries_mat/vn_adj.mat', 'vn_adj');

W = V;
coords = vn_coord;  
whos
figure;
gplotg(W,coords);

%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% task 6 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% Greece %%%%%%%%%
gr_coord=readtable('Datasets/Countries_Meshes/csv/GR-3117-pts.csv');

gr_adj=readtable('Datasets/Countries_Meshes/csv/GR-3117-adj.csv', 'ReadVariableNames',false);    

gr_adj=table2array(gr_adj);

gr_coord=table2array(gr_coord);
save('Datasets/Countries_mat/gr_coord.mat', 'gr_coord');
G = graph( gr_adj(:,1), gr_adj(:,2) );
G = adjacency(G);
G = full(G); 
gr_adj = G;
save('Datasets/Countries_mat/gr_adj.mat', 'gr_adj');

W = G;
coords = gr_coord;  
whos
figure;
gplotg(W,coords);

%%%%%% Switzerland %%%%%%

ch_coord=readtable('Datasets/Countries_Meshes/csv/CH-4468-pts.csv');

ch_adj=readtable('Datasets/Countries_Meshes/csv/CH-4468-adj.csv', 'ReadVariableNames',false);    

ch_adj=table2array(ch_adj);

ch_coord=table2array(ch_coord);
save('Datasets/Countries_mat/ch_coord.mat', 'ch_coord');
CH = graph( ch_adj(:,1), ch_adj(:,2) );
CH = adjacency(CH);
CH = full(CH); 
ch_adj = CH;
save('Datasets/Countries_mat/ch_adj.mat', 'ch_adj');

W = CH;
coords = ch_coord;  
whos
figure;
gplotg(W,coords);

%%%%%%% Russia %%%%%%
ru_coord=readtable('Datasets/Countries_Meshes/csv/RU-40527-pts.csv');

ru_adj=readtable('Datasets/Countries_Meshes/csv/RU-40527-adj.csv', 'ReadVariableNames',false);    

ru_adj=table2array(ru_adj);

ru_coord=table2array(ru_coord);
save('Datasets/Countries_mat/ru_coord.mat', 'ru_coord');
RU = graph( ru_adj(:,1), ru_adj(:,2) );
RU = adjacency(RU);
RU = full(RU); 
ru_adj = RU;

save('Datasets/Countries_mat/ru_adj.mat', 'ru_adj');

W = RU;
coords = ru_coord;  
whos
figure;
gplotg(W,coords);

