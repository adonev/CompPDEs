function normv = DiscreteNorm(v,h,p)

if p==1
    normv = h*norm(v,1);
elseif p==2
    normv = sqrt(h)*norm(v,2);
else
    normv = norm(v,inf);
end

end
