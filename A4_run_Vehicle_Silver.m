%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2021 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
% 
% Permission is hereby granted, free of charge, to any person obtaining a
% copy of this software and associated documentation files (the
% "Software"), to deal in the Software without restriction, including
% without limitation the rights to use, copy, modify, merge, publish,
% distribute, sublicense, and/or sell copies of the Software, and to permit
% persons to whom the Software is furnished to do so, subject to the
% following conditions:
% 
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
% MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
% NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
% DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
% OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
% USE OR OTHER DEALINGS IN THE SOFTWARE. */
%% Specifications and requirements
% # @Time    : 2021-5-3 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B0_matla_optmization_course
% # @IDE     : MATLAB R2018a
% # @File    : A4_run_Vehicle_Silver.m

%%  Main program
% clear all
clc

Moby=0.25.*[-0.6, 0.6,   1,    1, 0.75,-0.75,   -1,  -1,-0.6;...
           1.75,1.75,0.75,-1.25,-1.55,-1.55,-1.25,0.75,1.75];    
Rot=@(t) [cos(t),-sin(t); sin(t),cos(t)];

logiC=@(y,a,c)  1./(1+c*exp(-a*y));
logiC2=@(y)  2*(1./(1+1*exp(-10*y)))-1;
y=-0.5:0.05:0.5;
baseF=logiC2(y);
pln=@(k) baseF(k);

NofC=1;
NofC=3;
ccol=lines(NofC);

y=-0.5:0.05:0.5;
plines2=2*logiC(y,10*ones(1,1),1);
logiC=@(y,a,c)  1./(1+c*exp(-a*y));

y=-0.5:0.05:0.5;
plines2=2*logiC(y,10*ones(1,1),1)-1;

plinesM=repmat(plines2,[NofC 1]);

v_car=0.2*ones(NofC,1);
Phi_steering=zeros(NofC,1);
cPos_pre = [4*2*(rand(NofC,1) - 0.5) 2*(round(rand(NofC,1)*2) + 1)-4];
cPos_pre(1,:)=0;
cPos=[cPos_pre zeros(NofC,1)];
StMax=30/180*pi;
cLen=abs(min(Moby(2,:))-max(Moby(2,:)));
cPos(:,3)=(v_car/cLen).*atan(Phi_steering);

view_edge=[0 50; -10 10];

lanes=[-2; 0; 2];
road_edge=[-50 50; -4 4];
road_edge_y=repmat(road_edge(2,:)',[1 length(road_edge(2,:))]);
road_edge_x=repmat(road_edge(1,:),[length(road_edge(2,:)) 1]);
lane_y=repmat(lanes,[1 length(road_edge(2,:))]);
lane_x=repmat(road_edge(1,:),[length(lanes) 1]);


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
figure(98);clf;  hold on; 
set(98,'Position',[680   530   960   430]);

pp{1}=plot(road_edge_x',road_edge_y','k-','lineWidth',1.5);
pp{2}=plot(lane_x',lane_y','--','color',[1 1 1]*0.8,'lineWidth',3);


for j=1:NofC
    currPosMo=Rot(cPos(j,3)-pi/2)*Moby+repmat(cPos(j,1:2)',[1 size(Moby,2)]);
    pc{j,1}=plot(currPosMo(1,:),currPosMo(2,:),'-','LineWidth',3,'color',ccol(j,:)); 
    pc{j,2}=plot(cPos(j,1),cPos(j,2),'.','MarkerSize',22); 
end

axis equal;
set(gca,'xlim',view_edge(1,:),'ylim',view_edge(2,:));
grid on;
hold off; 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
figure(99);clf;  hold on; 
set(99,'Position',[680    20   960   430]);

pp{1}=plot(road_edge_x',road_edge_y','k-','lineWidth',1.5);
pp{2}=plot(lane_x',lane_y','--','color',[1 1 1]*0.8,'lineWidth',3);


for j=1:NofC
    currPosMo=Rot(cPos(j,3)-pi/2)*Moby+repmat(cPos(j,1:2)',[1 size(Moby,2)]);
    pb{j,1}=plot(currPosMo(1,:),currPosMo(2,:),'-','LineWidth',3,'color',ccol(j,:)); 
    pb{j,2}=plot(cPos(j,1),cPos(j,2),'.','MarkerSize',22); 
end

axis equal;
set(gca,'xlim',view_edge(1,:),'ylim',view_edge(2,:));
grid on;
hold off; 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

onTimes=10;
Tlen=[25 10];
tflag=logical(zeros(NofC,1));
keyN=ones(NofC,1);
signT=-ones(NofC,1);
pbackN=1;
posAll={};tLog=1;
posX=[];
posY=[];
posAng=[];
% for i=1:150
while(1)
    prePos=cPos;
    cPos(:,3)=cPos(:,3)+(v_car/cLen).*atan(Phi_steering);
    cPos(:,1:2)=cPos(:,1:2)+(v_car*[1 1]).*[cos(cPos(:,3)) sin(cPos(:,3))];

    % vehicle movement update
    for j=1:NofC
        currPosMo=Rot(cPos(j,3)-pi/2)*Moby+repmat(cPos(j,1:2)',[1 size(Moby,2)]);
        set(pc{j,1},'XData',currPosMo(1,:),'YData',currPosMo(2,:));
        set(pc{j,2},'XData',cPos(j,1),'YData',cPos(j,2));
    end
%     save(['pb',str2num(pbackN),'.mat']);
    
    key=find(tflag);
    if ~isempty(key)
        Phi_steering(key)=signT(key).*0.5.*pln(keyN(key))';
        keyN(key)=keyN(key)+1;
        tflag(keyN>size(baseF,2))=false;
        keyN(keyN>size(baseF,2))=1;
        disp(keyN(key));
    end
    key=find(~tflag);
    Phi_steering(key)=0;
    key2=find(mod(cPos(key,2)./2,1)>0);
    cPos(key(key2),2)=2*round(cPos(key(key2),2)./2);
    cPos(key(key2),3)=0;

    tempTF=(rand(length(key),1)>0.98);
    tflag(key)=tempTF;
    signT(tflag & keyN==1)=sign(cPos(tflag & keyN==1 ,2));
    key2=find(signT==0);
    signT(key2)=sign(rand(length(key2),1)-0.5);
    
     for j=1:NofC
        currPosMo=Rot(prePos(j,3)-pi/2)*Moby+repmat(prePos(j,1:2)',[1 size(Moby,2)]);
        set(pb{j,1},'XData',currPosMo(1,:),'YData',currPosMo(2,:));
        set(pb{j,2},'XData',prePos(j,1),'YData',prePos(j,2));
     end   

    figure(98); 
    title(double(tflag));
    drawnow;
    posAll{tLog}=cPos;
    posX(tLog,:)=cPos(:,1);   
    posY(tLog,:)=cPos(:,2);
    posAng(tLog,:)=cPos(:,3);
    tLog=tLog+1;
    if cPos(1,1)>road_edge(1,2); break; end
        
end
save(['pb',num2str(pbackN),'.mat']);


