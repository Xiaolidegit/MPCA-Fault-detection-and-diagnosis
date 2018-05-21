function [T2UCL1,QUCL]=func_PCA_detection(Xtrain,Xtest)
[X_row,X_col] = size(Xtrain);
%��׼������
X_mean = mean(Xtrain);  %������Xtrainƽ��ֵ                           
X_std = std(Xtrain);    %���׼��                      
[X_row,X_col] = size(Xtrain); %��Xtrain�С�����               

Xtrain=(Xtrain-repmat(X_mean,X_row,1))./repmat(X_std,X_row,1);

%��Э�������
sigmaXtrain = cov(Xtrain);
%��Э���������������ֽ⣬lamdaΪ����ֵ���ɵĶԽ���T����Ϊ��λ��������������lamda�е�����ֵһһ��Ӧ��
[T,lamda] = eig(sigmaXtrain);                            
% disp('����������С����');
% disp(lamda);
% disp('����������');
% disp(T);                                            

%ȡ�Խ�Ԫ��(���Ϊһ������)����lamdaֵ�������·�תʹ��Ӵ�С���У���Ԫ������ֵΪ1�����ۼƹ�����С��90%��������Ԫ����
D = flipud(diag(lamda));                            
num_pc = 1;                                         
while sum(D(1:num_pc))/sum(D) < 0.9   
num_pc = num_pc +1;
end                                                 
disp('��Ԫ����Ϊ');disp(num_pc);
disp('***********************************************');
%ȡ��lamda���Ӧ����������
P = T(:,X_col-num_pc+1:X_col);                            
TT=Xtrain*T;
TT1=Xtrain*P;
%�����Ŷ�Ϊ99%��95%ʱ��T2ͳ�ƿ�����                       
T2UCL1=num_pc*(X_row-1)*(X_row+1)*finv(0.95,num_pc,X_row - num_pc)/(X_row*(X_row - num_pc));


%���Ŷ�Ϊ95%��Qͳ�ƿ�����
for i = 1:3
    theta(i) = sum((D(num_pc+1:X_col)).^i);
end
h0 = 1 - 2*theta(1)*theta(3)/(3*theta(1)^2);
ca = norminv(0.95,0,1);
QUCL = theta(1)*(h0*ca*sqrt(2*theta(2))/theta(1) + 1 + theta(2)*h0*(h0 - 1)/theta(1)^2)^(1/h0);                           

%���߼�⣺
%��׼������
n = size(Xtest,1);
Xtest=(Xtest-repmat(X_mean,n,1))./repmat(X_std,n,1);

%��T2ͳ������Qͳ����
[r,y] = size(P*P');
I = eye(r,y);

T2 = zeros(n,1);
Q = zeros(n,1);
for i = 1:n
    T2(i)=Xtest(i,:)*P*pinv(lamda(X_col-num_pc+1:X_col,X_col-num_pc+1:X_col))*P'*Xtest(i,:)';  
    Q(i) = Xtest(i,:)*(I - P*P')*(I - P*P')'*Xtest(i,:)';                                                                                    
end

% sigma = cov(data);%M*M���󣬻��Э�������
% [v d] = eig(sigma);  %�����sigma��ȫ������ֵ����ɶԽ���d �� �����������ھ��� v ��
%                     %eig() ���� ��һ���������������� 
% d1=diag(d);         %��ȡd�ĶԽ���Ԫ�� 
% [d2,index]=sort(d1);  %������������ֵ
% cols =size(v,2);    %�����������������
% vsort = ones(row,cols);
% dsort = ones(row,1);
% for i=1:cols
%     vsort(:,i)=v(:,index(cols-i+1));%������������
%     dsort(i)=d1(index(cols-i+1));%��������ֵ
% end %Matlab�и�һά����������ʹ��sort������sort��X��������xΪ�����������
% 
% num_pc = 1;                                         
% while sum(dsort(1:num_pc))/sum(dsort) < 0.90   
%     num_pc = num_pc +1;
% end         
% 
% %ȡ��lamda���Ӧ����������
% P = vsort(:,1:num_pc);                            
% TT=data*vsort;
% TT1=data*P;
% %�����Ŷ�Ϊ99%��95%ʱ��T2ͳ�ƿ�����                       
% T2UCL=num_pc*(row-1)*(row+1)*finv(0.95,num_pc,row - num_pc)/(row*(row - num_pc));
% 
% 
% %���Ŷ�Ϊ95%��Qͳ�ƿ�����
% for i = 1:3
%     theta(i) = sum((dsort(num_pc+1:col)).^i);
% end
% h0 = 1 - 2*theta(1)*theta(3)/(3*theta(1)^2);
% ca = norminv(0.95,0,1);
% QUCL = theta(1)*(h0*ca*sqrt(2*theta(2))/theta(1) + 1 + theta(2)*h0*(h0 - 1)/theta(1)^2)^(1/h0);    
% 
% %%  ���߼��
% %��׼������
% test=zscore(test); %��׼�����ݣ�
% 
% %��T2ͳ������Qͳ����
% [r,y] = size(P*P');
% I = eye(r,y);
% n = size(test,1);
% T2 = zeros(n,1);
% Q = zeros(n,1);
% for i = 1:n
%     T2(i)=test(i,:)*P*pinv(d(1:num_pc,1:num_pc))*P'*test(i,:)';  
%     Q(i) = test(i,:)*(I - P*P')*(I - P*P')'*test(i,:)';                                                                                    
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����
count=0;
N= n;
for i=1:N
    if T2(i)>T2UCL1
        count=count+1;
    end
end
false_alarm=count/n
count2=0;
for i=1:N
    if Q(i)>QUCL 
        count2=count2+1;
    end
end
false_alarm2=count2/n

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%��ͼ
    figure
    subplot(3,1,1);
    plot(1:n,T2,'k');                                    
    title('��Ԫ����ͳ�����仯ͼ');
    %xlabel('������');
    ylabel('T^2');
    hold on;
    line([0,n],[T2UCL1,T2UCL1],'LineStyle','--','Color','r');

    subplot(3,1,2);
    plot(1:n,Q,'k');
   % xlabel('������');
    ylabel('SPE');
    hold on;
    line([0,n],[QUCL,QUCL],'LineStyle','--','Color','r');
    hold on;
 %���������
alpha=0.9;
S=lamda(X_col-num_pc+1:X_col,X_col-num_pc+1:X_col);
FAI=P*pinv(S)*P'/T2UCL1+(eye(X_col)-P*P')/QUCL;
S=cov(Xtrain);
g=trace((S*FAI)^2)/trace(S*FAI);
h=(trace(S*FAI))^2/trace((S*FAI)^2);
kesi =g*chi2inv(alpha,h);
 %% �ۺ�ָ��
subplot(3,1,3)
fai=(Q/QUCL)+(T2/T2UCL1);
plot(fai)
ylabel('��');
hold on;
line([0,n],[kesi,kesi],'LineStyle','--','Color','r');
title('���ָ��');

count3=0;
for i=1:N
    if fai(i)>kesi 
        count3=count3+1;
    end
end
false_alarm3=count3/n

% % %     
% % % %����ͼ
% % % %1.ȷ�����ʧ��״̬�ĵ÷�
% % % S = Xtest(51,:)*P(:,1:num_pc);
% % % r = [ ];
% % % for i = 1:num_pc
% % %     if S(i)^2/lamda(i) > T2UCL1/num_pc
% % %         r = cat(2,r,i);
% % %     end
% % % end
% % % 
% % % %2.����ÿ���������������ʧ�ص÷ֵĹ���
% % % cont = zeros(length(r),X_col);
% % % for i = length(r)
% % %     for j = 1:X_col
% % %         cont(i,j) = abs(S(i)/D(i)*P(j,i)*Xtest(51,j));
% % %     end
% % % end
% % % 
% % % %3.����ÿ���������ܹ���
% % % CONTJ = zeros(X_col,1);
% % % for j = 1:X_col
% % %     CONTJ(j) = sum(cont(:,j));
% % % end
% % % 
% % % %4.����ÿ��������Q�Ĺ���
% % % e = Xtest(51,:)*(I - P*P');
% % % contq = e.^2;
% % % 
% % % %5. ���ƹ���ͼ
% % %     figure;
% % % % %     subplot(2,1,1);
% % % % %     bar(CONTJ,'k');
% % % % %     xlabel('������');
% % % % %     ylabel('T^2������ %');
% % % % % 
% % % % %     subplot(2,1,2);
% % % % %     bar(contq,'k');
% % % % %     xlabel('������');
% % % % %     ylabel('Q������ %');
% % % subplot(121),bar(CONTJ),title('T^2ͳ��������ͼ');
% % % subplot(122),bar(contq),title('SPEͳ��������ͼ');
% % % 
% % % %% ���ӻ�
% % % figure
% % % boxplot(Xtest)
