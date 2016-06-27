function forces =Beam2D2Node_Forces(k,u)
%以上函数计算单元的应力，输入单元刚度矩阵k，节点位移u，
%输出单元节点力forces
%-----------------------------------------
forces = k * u;
