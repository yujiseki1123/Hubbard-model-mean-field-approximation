#input data
t = 1 
U = 2 
mix_ratio = 0.2 
delta_old = 0.1 

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
    H_up[1,1] = 0.5*(1-delta_old)*U
    H_up[2,2] = 0.5*(1+delta_old)*U
    H_up[1,2] = -t
    H_up[2,1] = -t

    H_dn[1,1] = 0.5*(1+delta_old)*U
    H_dn[2,2] = 0.5*(1-delta_old)*U
    H_dn[1,2] = -t
    H_dn[2,1] = -t

    #caluclating eigenvalues and eigenvectors
    H_up_eigval = eigvals(H_up)
    H_dn_eigval = eigvals(H_dn)

    H_up_eigval = eigvals(H_up)
    H_dn_eigval = eigvals(H_dn)

    #setting N_up and N_dn
    N_up_1 = H_up_eigvecs(1,1)^2
    N_up_2 = H_up_eigvecs(2,1)^2
    N_dn_1 = H_dn_eigvecs(1,1)^2
    N_dn_2 = H_dn_eigvecs(2,1)^2

    #calculating approx base energy E_tot 
    E_tot = H_up_eigval[1] + H_dn_eigval[1] - U*(N_up_1*N_dn_1 + N_up_2*N_dn_2)

    #new parameter 
    
end 