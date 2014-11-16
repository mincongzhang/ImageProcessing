function T = my_threshold(I,threshold)
% MY_THRESHOLD 
% this function returns the logical matrix of a image segmented by certain threshold
    [m n] = size(I);
    T = zeros(m,n);
    for i=1:m
        for j=1:n
            T(i,j) = (I(i,j) >= threshold);
        end
    end
T = logical(T);
end

