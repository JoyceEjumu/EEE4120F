using WAV
using Plots
using Random
using TickTock
using Statistics

function builtInMethod(noOfSamples)
    global Arr1=zeros(noOfSamples)
    Arr1 = (rand(noOfSamples)*2).-1;
    hWN = Plots.histogram(Arr1, title = "Method 1")
    Plots.display(hWN)
    println("Number of samples: ", noOfSamples)
    return(Arr1);
end

function createWhiteN(noOfSamples)
    global Arr2=zeros(noOfSamples);
    for i in 1:noOfSamples
        num=rand();
        newNum=(num*2)-1
        Arr2[i]=newNum;
    end
    println("Number of samples: ", noOfSamples)
    h = Plots.histogram(Arr2, title = "Method 2")
    Plots.display(h)
    return(Arr2); #,noOfSamples)
end


ArrMethod1=[]
ArrMethod2=[]
NumberOfSamplesTested1=[]
NumberOfSamplesTested2=[]
TestNumber=0;

println("Test 1 using the Built in method")
N1=15000

for i in 1:20
    tick();
    builtInMethod(N1)
    timeElapsed=tok();
    push!(ArrMethod1, timeElapsed)
    push!(NumberOfSamplesTested1, N1)
    println()
end


N2=15000
println("Test 2 using the written function")

for i in 1:20
    tick();
    createWhiteN(N2);
    timeElapsed=tok();
    push!(ArrMethod2, timeElapsed)
    push!(NumberOfSamplesTested2, N2)
    println()
end


TestNumber=+1
println("Test 1 using the Built in method")

tick();
builtInMethod(N1)
timeElapsed=tok();
println("Time taken: ", timeElapsed)
push!(ArrMethod1, timeElapsed)
push!(NumberOfSamplesTested1, N1)
println()


println("Test 2 using the written function")
tick();
createWhiteN(N2);
timeElapsed=tok();
println("Time taken: ", timeElapsed)
push!(ArrMethod2, timeElapsed)
push!(NumberOfSamplesTested2, N2)
#ArrMethod2.append(timeElapsed -1)
println()

println(ArrMethod1)
println(ArrMethod2)
println(TestNumber)

println("Mean method 1: ")
mean1=(mean!([1.],Arr1))
println(mean1)

println("Mean method 2")
mean2=(mean!([1.],Arr2))
println(mean2)

function manualCorr(xi,yi,xmean,ymean)
    numerator=sum((-xmean.+xi).*(-ymean.+yi));
    den1=sqrt.(sum((-xmean.+xi).^2));
    den2=sqrt.(sum(((-ymean.+yi)).^2));
    r=numerator/(den1.*den2);
    #println(r)
end

println(manualCorr(Arr1,Arr1,mean1,mean1));
R=cor(Arr1, Arr1);
println(R)

println(manualCorr(Arr2,Arr2,mean2,mean2));
R=cor(Arr2, Arr2);
println(R)

using Plots
x1 = 1:N1;
x2 = 1:N1
#y = (Arr1,Arr2); # These are the plotting data
#print(sizeof(N1))
plot(x1, Arr1, label="Method 1")
plot!(x2, Arr2, label="Method 2")
#println(Arr)
