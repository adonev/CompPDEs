function w_coarse = Coarsen(w,coarsening)
   w_coarse=sum(reshape(w, [coarsening, length(w)/coarsening]), 1)' / coarsening;
end
