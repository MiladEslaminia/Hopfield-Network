
clc;
close all
clear;
load 0.mat         %loading data
d(:,:,1)=A;
load 1.mat
d(:,:,2)=A;
load 2.mat
d(:,:,3)=A;
load 4.mat
d(:,:,4)=A;
load 6.mat
d(:,:,5)=A;
load 9.mat
d(:,:,6)=A;
load dot.mat
d(:,:,7)=A;
load 3.mat
d(:,:,8)=A;
d(d==0)=-1;         %Bipolar pattern

for i=1:8           %Building the input array
   B(i,:)=reshape(d(:,:,i),1,120);
end

T=zeros(120);              %weight array by Hebbian rule

for i=1:size(d,3)
    
T=T+B(i,:)'*B(i,:);
end

w=T;
for i=1:size(w,1)   %making diagonal values zero
    w(i,i)=0;
end


Et=zeros(1,8);
for p=1:8
Et(p)=-0.5*B(p,:)*w*B(p,:).'-B(p,:)*B(p,:).';
end
Et
p=7; %pattern select


J=zeros(12,10);
nx=randi([1,10],80,1);
ny=randi([1,12],80,1);

J=d(:,:,p);
for i=1:80
    J(ny(i),nx(i))=-J(ny(i),nx(i));
end
B_noise=reshape(J,1,120);
B(p,:)=B_noise; %comment out for recalling with training pattern

subplot(1,10,1);
imagesc(reshape(B(p,:),12,10));
title('Noisy Input');
axis off;


E0=-0.5*B(p,:)*w*B(p,:).'-B(p,:)*B(p,:).'
E1=0;
y0=B(p,:);
y1=y0; 

iterations=1;
con=1 %Convergence flag
while con
    %index=randperm(120); %Async learning
    %for i=1:120
    %   y1(index(i))=sign(B(p,index(i))+y1*w(index(i),:).');
   % end
     y1=sign(B(p,:)+y0*w.');  %sync learning
        
    E1=-0.5*y1*w*y1.'-B(p,:)*y1.'
    if (E1-E0)==0  %if no changes, exit, equilibrium is reached
        con=0;
    end
    E0=E1;
    
    subplot(1,10,iterations+1);
    imagesc(reshape(y1,12,10))
    title(iterations);
    axis off;

    iterations=iterations+1
end



    
    
        

      


