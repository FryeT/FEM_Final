function y =Beam2D2Node_Assemble(KK,k,i,j)
%以上函数进行单元刚度矩阵的组装
%输入单元刚度矩阵k，单元的节点编号i、j
%输出整体刚度矩阵KK
%-----------------------------------------
DOF(1)=3*i-2;
DOF(2)=3*i-1;
DOF(3)=3*i;
DOF(4)=3*j-2;
DOF(5)=3*j-1;
DOF(6)=3*j;
for n1=1:6
    for n2=1:6
        KK(DOF(n1),DOF(n2))=KK(DOF(n1),DOF(n2))+k(n1,n2);
    end
end
y = KK;