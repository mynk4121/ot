clc
clear all

%% input parameters
Var={'x_1','x_2','x3','s_1','s_2','sol'};
cost=[-2 0 -1 0 0 0];
a=[-1 -1 1 1 0 ; -1 2 -4 0 1 ];
b=[-5;-8];
A=[a b];
bv=[4 5];

%%
zjcj=cost(bv)*A-cost;
simplex_table=[zjcj; A];
array2table(simplex_table,'VariableNames',Var)
RUN=true;

%% Dual Simplex table 
while RUN
sol=A(:,end);
if any(sol<0)
     fprintf('The current BFS is not feasible \n');
     [leaving_value,pos_row]=min(sol);
     fprintf('Leaving row %d \n', pos_row);
     for i=1:size(A,2)-1
            if A(pos_row,i)<0
                ratio(i)= abs(zjcj(i)/A(pos_row,i));
            else
                ratio(i)=inf;
            end
     end
         [entering_value,pos_col]=min(ratio);
    fprintf('entering column %d \n', pos_col);
    bv(pos_row)=pos_col;
 pvt_key=A(pos_row, pos_col);
  A(pos_row,:)=A(pos_row,:)/pvt_key;
 for i=1:size(A,1)
 if i~=pos_row
 A(i,:)=A(i,:)-A(i, pos_col).*A(pos_row,:);
 end
 end
 zjcj=cost(bv)*A-cost;
 next_table=[zjcj;A];
  array2table(next_table,'VariableNames',Var)
 else
     RUN=false;
      z=input(' "0" for max problem and "1" for min problem : ');
     fprintf('The current table is feasible\n');
      if z==1
          obj_value=-zjcj(end)
      else
          obj_value=zjcj(end)
      end
end
end

