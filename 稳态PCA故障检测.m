

close all;
clear all;
clc;
% ��ȡ����
[num,txt,raw] = xlsread('C:\Users\liu-z\data\data_pre.xlsx');
xtrain = num(11674:13565,1:6);
xtest = num(17961:18600,1:6);
%����Ư�ƹ���
t = [1:640]'
t0 = ones(640,1)
xtest(1:640,6) = xtest(1:640,6)+((t-t0).*0.3125)
%���ù��ϼ��������㷨
func_PCA_detection(xtrain,xtest)


% N=size(xtest,1);
% monitortime=200;
% %% �����Ա��PCA����
% [P,T_test,SPE,T_alpha,SPE_alpha,contri6,t4,x,test_x,Latent]=detect(xtrain,xtest,N,monitortime);
% %%  ���Ʊ�Ҫ������ͼ��
% %********************************************
% figure(1);
% subplot(211),
% x_row=1:N;  
% T_alpha=T_alpha*(ones(size(x_row)));
% plot(x_row,T_alpha,'r-','LineWidth',2.5),hold on
% plot(T_test,'b-'); grid on;   xlabel('������');ylabel('T^2ͳ����');
% subplot(212),
% x_row=1:N;   
% SPE_alpha=SPE_alpha*(ones(size(x_row)));
% plot(x_row,SPE_alpha,'r-','LineWidth',2.5),hold on
% plot(SPE,'b-'); grid on;  xlabel('������');ylabel('SPEͳ����');
% % ����
% 
% 
% count=0;
% for i=1:N
%     if T_test(i)>T_alpha(i)
%         count=count+1;
%     end
% end
% false_alarm=count/N
% count2=0;
% for i=1:N
%     if SPE(i)>SPE_alpha(i)
%         count2=count2+1;
%     end
% end
% false_alarm2=count2/N
% figure(2);
% subplot(121),bar(t4),title('T^2ͳ��������ͼ');
% subplot(122),bar(contri6),title('SPEͳ��������ͼ');
% figure(3)
% boxplot(test_x)
% 







