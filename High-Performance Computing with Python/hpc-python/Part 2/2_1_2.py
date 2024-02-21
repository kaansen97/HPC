from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD
rank = comm.Get_rank()
size = comm.Get_size()

if rank == 0:
    sum = 0
    data = np.arange(4.)
    for i in range(1, size):
        comm.Send(data, dest=i, tag=i)
      
else:
    data = np.zeros(4)
    comm.Recv(data, source=0, tag=rank)
    print("Rank {} process has sum: {}".format(rank, str(np.sum(data))))
