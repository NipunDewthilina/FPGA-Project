# N = 4 #2
# a = [[1, 2], [3, 4]]
# b = [[5, 6], [7, 8]]

#Matrix 1 input
N = int(input("Enter the number of rows in square matrix:"))
  
# Initialize matrix
a = []
print("Enter the entries rowwise of matrix 1:")

for i in range(N):          # A for loop for row entries
    row1 = input().split(" ")
    row1 = list(map(int,row1))
    a.append(row1)

#Matrix 2 input
b = []
print("Enter the entries rowwise of matrix 2:")

for i in range(N):          # B for loop for row entries
    row2 = input().split(" ")
    row2 = list(map(int,row2))
    b.append(row1)

# a = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]
# b = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]

mem1 = [0] * 4096
mem2 = [0] * 4096
mem3 = [0] * 4096
mem4 = [0] * 4096

ii = 0
jj = N
kk = 2 * N

start_bit = 4094
#00
mem1[start_bit] = ii
mem1[start_bit-1] = jj
mem1[start_bit-2] = kk
mem1[start_bit-3] = int(N/2)
mem1[start_bit-4] = 2*N-int(N/2)
mem1[start_bit-5] = 3*N
mem1[start_bit-6] =jj #j reset
mem1[start_bit-7] = 2*N #k reset
#11
mem2[start_bit] = ii+int(N/2)
mem2[start_bit-1] = jj+int(N/2)
mem2[start_bit-2] = kk
mem2[start_bit-3] = N
mem2[start_bit-4] = 2*N
mem2[start_bit-5] = 3*N
mem2[start_bit-6] = jj+int(N/2)
mem2[start_bit-7] = 2*N
#10
mem3[start_bit] = ii+int(N/2)
mem3[start_bit-1] = jj
mem3[start_bit-2] = kk
mem3[start_bit-3] = N
mem3[start_bit-4] = 2*N-int(N/2)
mem3[start_bit-5] = 3*N
mem3[start_bit-6] = jj
mem3[start_bit-7] = 2*N
#01
mem4[start_bit] = ii
mem4[start_bit-1] = jj+int(N/2)
mem4[start_bit-2] = kk
mem4[start_bit-3] = int(N/2)
mem4[start_bit-4] = 2*N
mem4[start_bit-5] = 3*N
mem4[start_bit-6] = jj+int(N/2)
mem4[start_bit-7] = 2*N

#ik
for i in range(ii, jj):
    for k in range(kk, 3 * N):

        loc1 = bin(i)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(k)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        # print(decimal_loc, a[i][k % N])
        mem1[decimal_loc] = a[i][k % N]
        mem2[decimal_loc] = a[i][k % N]
        mem3[decimal_loc] = a[i][k % N]
        mem4[decimal_loc] = a[i][k % N]

#ik
for k in range(kk, 3 * N):
    for j in range(jj, kk):

        loc1 = bin(k)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(j)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        # print(decimal_loc, b[k % N][j % N])
        mem1[decimal_loc] = b[k % N][j % N]
        mem2[decimal_loc] = b[k % N][j % N]
        mem3[decimal_loc] = b[k % N][j % N]
        mem4[decimal_loc] = b[k % N][j % N]

# print(mem[0], mem[2500], mem[4], mem[5], mem[68], mem[69], mem[258], mem[259], mem[322], mem[323], mem[2345], mem[21], mem[32], mem[450])      

with open('mat_core1.txt', 'w') as file:
    for i in mem1:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core2.txt', 'w') as file:
    for i in mem2:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core3.txt', 'w') as file:
    for i in mem3:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

with open('mat_core4.txt', 'w') as file:
    for i in mem4:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

#result indices finding
addr_mem = [0]*512
addr_i = 0;
for i in range(ii, jj):
    for j in range(jj, 2 * N):

        loc1 = bin(i)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(j)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        print(decimal_loc)
        addr_mem[addr_i] = decimal_loc
        addr_i += 1
print(addr_mem)

with open('addr_mem.txt', 'w') as file:
    for i in addr_mem:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')

#matrix multiplication for verification
resultant = []

for i in range(N):
    row = []
    for j in range(N):
        row.append(0)
    resultant.append(row)
        
for i in range(N):
    for j in range(int(N)):
        for k in range(int(N)) :
            resultant[i][j] += a[i][k] * b[k][j] 

print(resultant)