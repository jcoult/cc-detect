function [ y ] = minSecond( x )
y = min(x(x>min(x)));
end