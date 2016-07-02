%% ϰ��1
% һ�����㽨�����Լ�Ϊͼ3��ʾģ�ͣ�
% ���ĵĲ���Ϊ $A=4*10^{-2}$ $m^2$�� $I=6.75*10^{-4}$ $m^4$��
% ���ϵĵ���ģ��Ϊ $E=2*10^5$ $MPa$���Է����ýṹ������ȡ֧������ 
%%
% 
% <<xiti1.png>>
% 
%%
% *���*
% �ڵ��ż���Ԫ�����ͼ��ʾ��
%%
%
% <<��ܵ�Ԫ�����ڵ���.png>>
% 
%% 
A = 4e-2;
I = 6.75e-4;
E = 2e11;  % ��λPa��= 2e5 MPa
h = 3;
l = 4;
k1 = Beam2D2Node_Stiffness(E,I,A,l); % ������Ԫ�նȾ���
k2 = Beam2D2Node_Stiffness(E,I,A,h); % ������Ԫ�նȾ���,�ֲ�����ϵ��
T = [0,1,0,0,0,0;
    -1,0,0,0,0,0;
    0,0,1,0,0,0;
    0,0,0,0,1,0;
    0,0,0,-1,0,0;
    0,0,0,0,0,1];
k3 = T'* k2 * T; % ��������������ϵ�µ�Ԫ�նȾ���
KK = zeros(27,27); % ����նȾ����ʼ��
KK = Beam2D2Node_Assemble(KK,k3,1,2);
KK = Beam2D2Node_Assemble(KK,k3,2,4);
KK = Beam2D2Node_Assemble(KK,k1,4,6);
KK = Beam2D2Node_Assemble(KK,k1,2,5);
KK = Beam2D2Node_Assemble(KK,k3,5,6);
KK = Beam2D2Node_Assemble(KK,k3,3,5);
KK = Beam2D2Node_Assemble(KK,k1,6,8);
KK = Beam2D2Node_Assemble(KK,k1,5,7);
KK = Beam2D2Node_Assemble(KK,k3,7,8);
KK = Beam2D2Node_Assemble(KK,k3,9,7);
p=[0,-4e4,-2.667e4, 0,-2.5e4,-1.667e4, 0,-8e4,0,... 
    0,-5e4,0, 0,-4e4,2.6667e4, 0,-2.5e4,1.6667e4]';
% P=[Frx1,Fry1,M1, 0,-4e4,-2.6667e4, Frx3,Fry3,M3, 0,-2.5e4,-1.667e4,
% 0,-8e4,0, 0,-5e4,0, 0,-4e4,2.6667e4, 0,-2.5e4,1.6667e4, Frx9,Fry9,M9]
% λ�Ʊ߽�����Ϊ��u1=v1=theta1=0��u3=v3=theta3=0,u9=v9=theta9=0;
k = KK([4:6,10:24],[4:6,10:24]);
u = k\p;
U = [0;0;0;u(1:3);0;0;0;u(4:end);0;0;0];
P = KK * U;
%% ������
% λ�ƽ�����£�
fprintf('u2=%10.6f mm,\tv6=%10.6f mm,\ttheta2=%10.2G rad\n',u(1:2)*1000,u(3));
fprintf('u4=%10.6f mm,\tv4=%10.6f mm,\ttheta4=%10.2G rad\n',u(4:5)*1000,u(6));
fprintf('u5=%10.6f mm,\tv5=%10.6f mm,\ttheta5=%10.2G rad\n',u(7:8)*1000,u(9));
fprintf('u6=%10.6f mm,\tv6=%10.6f mm,\ttheta6=%10.2G rad\n',u(10:11)*1000,u(12));
fprintf('u7=%10.6f mm,\tv7=%10.6f mm,\ttheta7=%10.2G rad\n',u(13:14)*1000,u(15));
fprintf('u8=%10.6f mm,\tv8=%10.6f mm,\ttheta8=%10.2G rad\n',u(16:17)*1000,u(18));
% ֧����������£�
fprintf('Frx1=%10.2f N,\tFry1=%10.2f N,\tM1=%10.2f N*m\n',P(1:3));
fprintf('Frx3=%10.2f N,\tFry3=%10.2f N,\tM3=%10.2f N*m\n',P(7:9));
fprintf('Frx9=%10.2f N,\tFry9=%10.2f N,\tM9=%10.2f N*m\n',P(25:27));