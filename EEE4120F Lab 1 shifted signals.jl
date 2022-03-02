using Plots
using Statistics

frequency=0.1 #Hz
sampleSize=100 #100 1000 10000

x = Array(-sampleSize/2:0.01:sampleSize/2);
y = sin.(frequency.*x);
plot(x,y)

shift=10;
yShifted=circshift(y,shift);
plot(x,yShifted)
#Plots.scatter()

R=cor(y, yShifted);
println(R)
