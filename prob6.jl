using LinearAlgebra
using Plots 

function self_consistent(n,U,iter_num)
    #input data
    t = 1 
    mix_ratio = 0.2 
    delta = 0.1 
    E_tot = 0 

    #initializing hamiltonian
    H_up = zeros(n,n)

    H_dn =　zeros(n,n)

    #self-consistent calculation 
    for iter = 1:iter_num
        #setting hamiltonian
        for i = 1:n 
            H_up[i,i] = 0.5*(1+(-1)^i*delta)*U
            H_dn[i,i] = 0.5*(1-(-1)^i*delta)*U
            
            if i != n
                H_up[i,i+1] = -t 
                H_up[i+1,i] = -t

                H_dn[i,i+1] = -t 
                H_dn[i+1,i] = -t
            end 
        end 

        #caluclating eigenvalues and eigenvectors
        H_up_eigval = eigvals(H_up)
        H_dn_eigval = eigvals(H_dn)

        H_up_eigvec = eigvecs(H_up)
        H_dn_eigvec = eigvecs(H_dn)

        #calculating mean_tot from n_up and n_dn. Also creating new parameter delta_new
        mean_tot = 0 
        delta_new = 0 

        for i = 1:n
            n_up = H_up_eigvec[i,1]^2
            n_dn = H_dn_eigvec[i,1]^2
            
            mean_tot = mean_tot + n_up * n_dn

            if i == 1
                delta_new = n_up - n_dn
            end 
        end 

        #calculating approx base energy E_tot 
        E_tot = H_up_eigval[1] + H_dn_eigval[1] - U*mean_tot


        #print result 
        #print(i," ",E_tot," ",delta_new)
        
        #mixing 
        delta = mix_ratio * delta_new + (1 - mix_ratio) * delta
    end 

    return [delta,E_tot]
end 

x = [U*0.1 for U = 1:200]

res = [self_consistent(6,U*0.1,100) for U = 1:200]
MF_delta = [res[i][1] for i = 1:200]
MF_ene = [res[i][2] for i = 1:200]
f(x) = 0 

plot(x,MF_delta,label="MF",xlabel="U/t",ylabel="Δ")
plot!(f,label="exact")