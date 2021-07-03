N = 4 #2
# a = [[1, 2], [3, 4]]
# b = [[5, 6], [7, 8]]

a = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]
b = [[1, 2, 1, 2], [1, 2, 1, 2], [1, 2, 1, 2], [3, 2, 1, 0]]

mem = [0] * 4096

ii = 0
jj = N
kk = 2 * N

start_bit = 4094
mem[start_bit] = ii
mem[start_bit-1] = jj
mem[start_bit-2] = kk
mem[start_bit-3] = N
mem[start_bit-4] = 2*N
mem[start_bit-5] = 3*N

#ik
for i in range(ii, jj):
    for k in range(kk, 3 * N):

        loc1 = bin(i)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(k)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        print(decimal_loc, a[i][k % N])
        mem[decimal_loc] = a[i][k % N]

#ik
for k in range(kk, 3 * N):
    for j in range(jj, kk):

        loc1 = bin(k)[2:]
        sixloc1 = (6 - len(loc1)) * '0' + loc1

        loc2 = bin(j)[2:]
        sixloc2 = (6 - len(loc2)) * '0' + loc2

        twelveloc = sixloc1 + sixloc2

        decimal_loc = int(twelveloc, 2)

        print(decimal_loc, b[k % N][j % N])
        mem[decimal_loc] = b[k % N][j % N]

# print(mem[0], mem[2500], mem[4], mem[5], mem[68], mem[69], mem[258], mem[259], mem[322], mem[323], mem[2345], mem[21], mem[32], mem[450])      

with open('mat445.txt', 'w') as file:
    for i in mem:
        i_s = str(bin(int(i)))[2:]
        zeros = "0" * (12-len(str(i_s)))
        file.write(zeros+str(i_s)+'\n')
        # print(i)
        # print(str(i)+'\n')