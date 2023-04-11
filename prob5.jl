using LinearAlgebra

#input data
t = 1 
U = 2 
mix_ratio = 0.2 
delta = 0.1 
E_tot = 0 

#initializing hamiltonian
H_up = [
        0.0　0.0
        0.0　0.0
        ]

H_dn = [
        0.0　0.0
        0.0　0.0
        ]

#self-consistent calculation 
for i = 1:10000
    #setting hamiltonian
    H_up[1,1] = 0.5*(1-delta)*U
    H_up[2,2] = 0.5*(1+delta)*U
    H_up[1,2] = -t
    H_up[2,1] = -t

    H_dn[1,1] = 0.5*(1+delta)*U
    H_dn[2,2] = 0.5*(1-delta)*U
    H_dn[1,2] = -t
    H_dn[2,1] = -t

    #caluclating eigenvalues and eigenvectors
    H_up_eigval = eigvals(H_up)
    H_dn_eigval = eigvals(H_dn)

    H_up_eigvec = eigvecs(H_up)
    H_dn_eigvec = eigvecs(H_dn)

    #setting N_up and N_dn
    N_up_1 = H_up_eigvec[1,1]^2
    N_up_2 = H_up_eigvec[2,1]^2
    N_dn_1 = H_dn_eigvec[1,1]^2
    N_dn_2 = H_dn_eigvec[2,1]^2

    #calculating approx base energy E_tot 
    global E_tot = H_up_eigval[1] + H_dn_eigval[1] - U*(N_up_1*N_dn_1 + N_up_2*N_dn_2)

    #new parameter 
    delta_new = N_up_1 - N_dn_1

    #print result 
    #print(i," ",E_tot," ",delta_new)
    
    #mixing 
    global delta = mix_ratio * delta_new + (1 - mix_ratio) * delta
end 

print(E_tot)