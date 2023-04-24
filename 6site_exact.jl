using Combinatorics
using LinearAlgebra
using Plots 
a = [0,0,0,1,1,1]
b = [0,0,0,1,1,1]
#a = [0,1]
ele_1 = unique(collect(permutations(a)))
#ele_2 = ele_1
ele_2 = unique(collect(permutations(b)))
spins = Array[]
for x in ele_1
    for y in ele_2
        new = [[x,y]]
        append!(spins,new)
    end
end 



n = length(spins)
m = length(spins[1][1])

function calc_eig_val(t,U)
    ham = zeros(n,n)

    #符号関数

    # tと-tの埋め込み
    for i = 1:n
        for j = 1:n
            if i == j 
                continue 
            end
            if spins[i][1] == spins[j][1]
                for k = 1:m
                    if k==m 
                        l = 1 
                    else 
                        l = k + 1
                    end 
                    
                    spin_tmp = copy(spins[i][2])


                    if spins[i][2][k] == 0 && spins[i][2][l] == 1 
                        spin_tmp[k] = 1 
                        spin_tmp[l] = 0 

                    elseif spins[i][2][k] == 1 && spins[i][2][l] == 0
                        spin_tmp[k] = 0
                        spin_tmp[l] = 1 

                    else 
                        continue 
                    end 
                    
                    #反交換関係による符号変換
                    if spin_tmp == spins[j][2]
                        if l == 1 
                            if spins[j][1][l] == 1 
                                ham[i,j] = t 
                            else 
                                ham[i,j] = -t 
                            end 
                        else 
                            if spins[j][1][l] == 1 
                                ham[i,j] = -t
                            else 
                                ham[i,j] = t 
                            end 
                        end 
                        #println(spins[i]," ",spins[j])
                        break 
                    end  
                end

            elseif spins[i][2] == spins[j][2]
                for k = 1:m
                    if k==m 
                        l = 1 
                    else 
                        l = k + 1
                    end

                    spin_tmp = copy(spins[i][1])

                    if spins[i][1][k] == 0 && spins[i][1][l] == 1 
                        spin_tmp[k] = 1 
                        spin_tmp[l] = 0 
                    elseif spins[i][1][k] == 1 && spins[i][1][l] == 0
                        spin_tmp[k] = 0
                        spin_tmp[l] = 1 
                    end 
                    
                    #反交換関係による符号変換
                    if spin_tmp == spins[j][1]
                        if l == 1 
                            if spins[j][2][k] == 1
                                ham[i,j] = t 
                            else 
                                ham[i,j] = -t 
                            end   
                        else 
                            if spins[j][2][k] == 1 
                                ham[i,j] = -t 
                            else 
                                ham[i,j] = t
                            end 
                        end 
                        #println(spins[i]," ",spins[j])
                        break 
                    end  
                end
            end 
        end
    end 

    #Uの埋め込み

    for i = 1:n 
        for j = 1:m 
            if spins[i][1][j] == 1 && spins[i][2][j] == 1
                ham[i,i] = ham[i,i] + U
            end 
        end 

    end 

    #print(ham)

    eig_vals = eigvals(ham)
    return eig_vals[1]
    
end 

#print(calc_eig_val(-1,0))

y = [calc_eig_val(-1,U*1)　for U = 1:2000]
pushfirst!(y,calc_eig_val(-1,0))

plot(x,MF_ene,label="MF",xlabel="U/t",ylabel="E/t")
plot!(x,y,label="exact")
