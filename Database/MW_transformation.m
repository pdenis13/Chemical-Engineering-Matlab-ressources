n = size(MW_organic.Formula,1);
MM =[];
M1 = [];
for i = 1:n
  MM(i) =   mweight_simple(MW_organic.Formula{i});
  
end

MM = MM';
