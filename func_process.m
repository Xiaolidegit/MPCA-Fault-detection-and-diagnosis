function [x_process] = func_process(x_origin)
x_process = [x_origin(:,1:6)];
% x_math = [x_origin(:,16:17),x_origin(:,28)];
[row1,col1]=size(x_process);
% [row2,col2]=size(x_math);
len = [1:row1];
% len2 = [1:row2];
% ���ӻ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% plot(len,x_process(len,1),'r',len,x_process(len,2),'b');
% hold on;
% grid on
% 
% 
% figure 
% plot(len,x_process(len,3),'r',len,x_process(len,6),'b');
% hold on;
% grid on;

% figure
% plot(len,x_process(len,8),'r',len,x_process(len,9),'b')
% hold on;
% grid on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%�޳��쳣ֵ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% subplot(2,1,1)
% plot(len,x_process(len,10),'k')
% hold on
% title('��ȴˮ�²�ԭʼ����')
% grid on
x_process = data_clean(x_process,col1) ;
[row1,col1] = size(x_process);
len1 = [1:row1];
% x_math = data_clean(x_math,col2);
% [row2,col2] = size(x_math);
% len2 = [1:row2];
% subplot(2,1,2)
% plot(len,x_process(len,10),'k')
% hold on
% title('�쳣ֵ����������')
% grid on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%С��ȥ��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
len = len1;
% figure
% subplot(2,1,1)
% plot(len,x_process(len,3),'k')
% hold on
% title('��ȴˮѭ������ԭʼ����')
% grid on
for i=1:col1
    [x_process(:,i),xd,lxd] = wden(x_process(:,i),'minimaxi','s','one',6,'db2');
end
% for i=1:col2
%     [x_math(:,i),xd,lxd] = wden(x_math(:,i),'minimaxi','s','one',5,'db2');
% end
% subplot(2,1,2)
% plot(len,x_process(len,3),'k')
% hold on
% title('С��ȥ��������')
% grid on
% x_process = zscore(x_process);
% x_math = zscore(x_math);



end