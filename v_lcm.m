format short
clear all
clc
%% Input Parameters
Cost=[6 4 1 5;8 9 2 7;4 3 6 4];
A=[14 16 5];
B=[6 10 15 4];

%% Check if the problem is balanced or unbalanced
if sum(A)==sum(B)
    fprintf('Given transportation problem is Balanced \n')
else
     fprintf('Given transportation problem is Unbalanced \n')
      if sum(A)<sum(B) %need to add a dummy row
         Cost(end+1,:)=zeros(1,length(B));
         A(end+1)=sum(B)-sum(A)
      else if sum(A)>sum(B) %need to add a dummy column
         Cost(:,end+1)=zeros(length(A),1);
         B(end+1)=sum(A)-sum(B)
     end
      end
end
%% Least cost method starts
InitialCost=Cost
X=zeros(size(Cost));
[m n]=size(Cost);
BFS=m+n-1;
for i=1:size(Cost,1)
    for j=1:size(Cost,2)
Mincost=min(Cost(:))
if Mincost==Inf
    break
end
[rowind colind]=find(Mincost==Cost)
% Assign allocations to each cost
x1=min(A(rowind),B(colind)) %allocations to found min cost
[val ind]=max(x1)
ii=rowind(ind) %identify row position of the allocation
jj=colind(ind) %identify col position of the allocation
y1=min(A(ii),B(jj)) %find out of row n col which one can be allocated
X(ii,jj)=y1 %assign allocation
if min(A(ii),B(jj))==A(ii)
B(jj)=B(jj)-A(ii)
A(ii)=A(ii)-X(ii,jj)
Cost(ii,:)=Inf
else
    A(ii)=A(ii)-B(jj)
    B(jj)=B(jj)-X(ii,jj)
    Cost(:,jj)=Inf
end
    end
end

%% Print initial BFS
fprintf('Initial BFS=\n')
IBFS=array2table(X)

%% Check for degenerate or non degenerate soln
TotalBFS=length(nonzeros(X));
if TotalBFS==BFS
    fprintf('Initial BFS is non degenerate \n')
else
    fprintf('Initial BFS is degenerate \n')
end
%% Compute initial transportation cost
ICC=sum(sum(InitialCost.*X));
fprintf('Initial BFS Cost is %d \n', ICC)