from mpi4py import MPI
import numpy as np
comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()
dims = MPI.Compute_dims(size, [0, 0])

periods = [1, 1]
cart = comm.Create_cart(dims, periods=periods, reorder=False)
coord = cart.Get_coords(rank)
# neighbors
south, north = cart.Shift(0, 1)
west,  east = cart.Shift(1, 1)
grid = np.full((8, 8), rank)
send = np.repeat(rank, 6)

receive = []

req = comm.isend(send, dest=east, tag=0)
req.wait()

req = comm.isend(send, dest=west, tag=0)
req.wait()

req = comm.isend(send, dest=south, tag=0)
req.wait()

req = comm.isend(send, dest=north, tag=0)
req.wait()

req = comm.irecv(source=east, tag=0)
receive = req.wait()

grid[1:7, 7] = np.repeat(receive, 1)

req = comm.irecv(source=west, tag=0)
receive = req.wait()
grid[1:7, 0] = np.repeat(receive, 1)

req = comm.irecv(source=south, tag=0)
receive = req.wait()
grid[7, 1:7] = np.repeat(receive, 1)

req = comm.irecv(source=north, tag=0)
receive = req.wait()
grid[0, 1:7] = np.repeat(receive, 1)


if rank == 0:
    print("Rank: " + str(rank))
    print("coordinates: " + str(coord))
    print("Neighbours: " "west:" + str(west) + "\t east: " + str(east) +
          "\t south: " + str(south) + "\t north: " + str(north))

    print("\n")
    print(grid)
