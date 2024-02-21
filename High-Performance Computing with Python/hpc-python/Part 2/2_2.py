from mpi4py import MPI

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()

dims = [0, 0]
dims = MPI.Compute_dims(size, dims)

# create two-dimensional non-periodic Cartesian topology
periods = [True, True]
comm_cart = comm.Create_cart(dims, periods=periods)
# get rank's coordinates in the topology
coords = comm_cart.Get_coords(rank)
# get rank's south/north/west/east neighbors
neigh_west,  neigh_east  = comm_cart.Shift(0, 1)
neigh_south, neigh_north = comm_cart.Shift(1, 1)

print("Rank: " + str(rank))
print("Coordinates: " + str(coords))
print("Neighbours:- ")
print(" West: " + str(neigh_west))
print(" East: " + str(neigh_east))
print(" South: " + str(neigh_south))
print(" North: " + str(neigh_north))

