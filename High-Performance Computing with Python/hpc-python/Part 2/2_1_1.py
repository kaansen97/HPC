from mpi4py import MPI

comm = MPI.COMM_WORLD
size = comm.Get_size()
rank = comm.Get_rank()
 
if rank==0:
   left=size-1
   right=1
elif rank==size-1:
   left=size-2
   right=0   
else:
   right = (rank + 1)
   left  = (rank - 1)
data=rank
sum=0
for i in range(0, size):
   comm.send(data, dest=right)
   data = comm.recv(source=left)
   sum = sum+data

print('sum=%d, rank=%d' % (sum, data))

