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
% # @Time    : 2021-5-16 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B0_matla_optmization_course
% # @IDE     : MATLAB R2018a
% # @File    : R1_state_gen_Silver.m

%%  Main program
% clear all

NofU=11;
fignum=1;
obSize=[-6 6; -1 7];

figTitle='Robot for Pick & Place';
label={'container','box1','box2','launch_box','area1','area2','robot','robot_j1','robot_j2','robot_j3','hand','object1','object2','initial_state','final_state'};
posU{1}=[-6 -6 -2 -2; 0.25 0 0 0.25]; % container
posU{2}=[-6+0.1 -6+0.1 -4-0.1 -4-0.1; 0.25 0.05 0.05 0.25]; % box1
posU{3}=[-4+0.1 -4+0.1 -2-0.1 -2-0.1; 0.25 0.05 0.05 0.25]; % box2
posU{4}=[-posU{1}(1,:); posU{1}(2,:)]; % launch_box
posU{5}=[-posU{2}(1,:); posU{2}(2,:)]; % area1
posU{6}=[-posU{3}(1,:); posU{3}(2,:)]; % area2
posU{7}=[0 -1 -1 0 1 1; 0.25 0.25 -0.25 -0.25 -0.25 0.25]; % robot_base

posR=zeros(2,8,6);
posR(:,1,1)=[0;0.25]; % robot_j1
posR(:,:,2)=[-4 -2 2 4 -2 0 0 2; 4 4 4 4 4 4 4 4]; % robot_j2
posR(:,:,3)=[-5 -3 3 5 -4 -2 2 4; 2 2 2 2 3 3 3 3]; % robot_j3
posR(:,:,4)=[-5.5 -4.5 -3.5 -2.5 2.5 3.5 4.5 5.5; 0.7 0.7 0.7 0.7 0.7 0.7 0.7 0.7]; % hand
posRd=4;
posObj=[posR(1,:,4); posR(2,:,4)-0.45]; % object1 or object2

handS(:,:,1)=[-0.5 0 0.5;   -0.5 0 -0.5]; % hand for opening
handS(:,:,2)=[-0.25 0 0.25; -0.6 0 -0.6]; % hand for picking with an object
handS(:,:,3)=[-0.1 0 0.1;   -0.7 0 -0.7]; % hand for picking in the empty space

colorU=[
    0 0 0; % container
    1 0 0; % box1
    0 0 1; % box2
    0 0 0; % launch_box
    1 0 0; % area1
    0 0 1; % area2
    0 0 0; % robot_base
    0 0 0; % robot_j1
    0 0 0; % robot_j2
    0 0 0; % robot_j3
    0 0 0; % hand
    1 1 1; % object none
    1 0 0; % object1
    0 0 1; % object2
    ];

LWidth=[
    2; % container
    1; % box1
    1; % box2
    2; % launch_box
    1; % area1
    1; % area2
    3; % robot_base
    3; % robot_j1
    3; % robot_j2
    3; % robot_j3
    3; % hand
    4; % object1
    4; % object2
    ];

posU(7)=cellfun(@(x) [x,x(:,1)],posU(7),'UniformOutput',false);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
figure(fignum); clf;
% set(fignum,'Position',[560   500   800   450]); 
hold on;

spbtn = uicontrol('Style','pushbutton','Units','normalized',...
        'Position',[.93  .2  .05  .1],'String','Stop it');
set(spbtn,'interruptible','on','Callback','itr = 0;');
set(fignum,'doublebuffer','on');
set(gca,'drawmode','fast');
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

% ~~~~~~~~~MakeQTMovie <initialize> (start)~~~~~~~~~~~~~~
% You need to place "MakeQTMovie.m" (c) Copyright Malcolm Slaney, Interval Research, March 1999.
% in the same folder of this file

Flag_write_Movie=1; 
Nm=1;
pbackN=1;
pbackN=pbackN+1;
Nm=Nm+1; % the serial number of the movie 
f_folder='robotSIM'; % the output folder of the movie
if ~isdir(f_folder); mkdir(f_folder); end
f_prefix='roboM'; % the output file name
if Flag_write_Movie == 1
    MovieFileName = strcat(f_prefix,num2str(Nm),'.mov'); 
    fprintf('Creating the movie file %s.\n', fullfile(f_folder,MovieFileName));
    MakeQTMovie('start',fullfile(f_folder,MovieFileName));
    MakeQTMovie('size', [800   450]);
    MakeQTMovie('quality', 1.0);
    fps = 5; 
%   fps = 30;
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~


tLd=-0.3*[2 1 1 2 1 1 2]; fsize=14; flenS=0.0035*fsize;
for k=1:length(tLd)
    text(mean(posU{k}(1,:))-flenS*length(label{k}),tLd(k),strrep(label{k},'_',' '),'FontSize',fsize); 
end
tlabelPos=[0 5];
tlabel='';
tStatus=text(tlabelPos(1)-flenS*length(tlabel),tlabelPos(2),strrep(tlabel,'_',' '),'FontSize',fsize);

NofU=7;
for i=1:NofU
    plot(posU{i}(1,:),posU{i}(2,:),'-','color',colorU(i,:),'LineWidth',LWidth(i));
end
% hold off;
set(gca,'xlim',obSize(1,:),'ylim',obSize(2,:));
axis equal; grid on;

pID=1;
pp=plot(permute(posR(1,pID,1:4),[3 2 1]),permute(posR(2,pID,1:4),[3 2 1]),'-','color',colorU(8,:),'LineWidth',LWidth(8));
pp2=plot(handS(1,:,1),handS(2,:,1),'-','color',colorU(11,:),'LineWidth',LWidth(11));
for k=1:size(posObj,2)
    pp3{k}=plot(posObj(1,k,1),posObj(2,k,1),'.','Color',colorU(14,:),'MarkerSize',60);
end
title(figTitle);
set(fignum,'name',strrep(figTitle,' ','_'));

postureR=[
    1 1 1 1;
    1 1 1 2;
    1 2 2 3;
    1 2 2 4;
    1 3 3 5;
    1 3 3 6;
    1 4 4 7;
    1 4 4 8];

postureR_pick=postureR;
postureR_pick(:,2:3)=postureR_pick(:,2:3)+4;

xD=permute(posR(1,:,1:posRd),[2 3 1]); xDf=xD(:);
yD=permute(posR(2,:,1:posRd),[2 3 1]); yDf=yD(:);

xD_pick=xDf;
yDf_pick=yDf; 
upH=0.5;
yDf_pick(end-size(postureR,1)+1:end)=yDf_pick(end-size(postureR,1)+1:end)+upH;

obSet=colorU(12:14,:); 
cON=colorU(14,:);
itr=1;

obSt=floor(rand(1,size(postureR,1))*3)+1;
exOb=logical(obSt==1);
obYpos=posObj(2,:)-2.*exOb;
grip=repmat([1 2],[size(postureR,1) 1])+[zeros(size(postureR,1),1) (obSt==1)'];
for k=1:size(postureR,1)
    set(pp3{k},'YData',obYpos(k),'Color',obSet(obSt(k),:));
end
for pID=1:size(postureR,1)
    key=postureR(pID,:)+(([1:posRd]-1)*size(xD,1));
    set(pp,'XData',xDf(key),'YData',yDf(key));
    for j=grip(pID,:)        
        set(pp2,'XData',handS(1,:,j)+xDf(key(end)),'YData',handS(2,:,j)+yDf(key(end)));
%         pause(0.3);
    % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        end
     % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
        drawnow;
    end
    if exOb(pID)
        tlabel='no object';
        set(tStatus,'Position',tlabelPos-[1.2*flenS*length(tlabel) 0],'String',tlabel);
        for j=grip(pID,:)        
            set(pp2,'XData',handS(1,:,j)+xDf(key(end)),'YData',handS(2,:,j)+yDf(key(end)));
%         pause(0.1);
    % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        end
     % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
            drawnow;
        end
    else
        tlabel='pick successfully';
        set(tStatus,'Position',tlabelPos-[1.2*flenS*length(tlabel) 0],'String',tlabel);
        key=postureR_pick(pID,:)+(([1:posRd]-1)*size(xD,1));
        set(pp,'XData',xD_pick(key),'YData',yDf_pick(key));
        j=grip(pID,2);       
        set(pp2,'XData',handS(1,:,j)+xD_pick(key(end)),'YData',handS(2,:,j)+yDf_pick(key(end)));
        set(pp3{pID},'YData',obYpos(k)+upH);
%         pause(0.3);
    % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        end
     % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
     drawnow;
    end
    if itr==0; break; end  
end

     

% ~~~~~~~~~MakeQTMovie  <finalize> (start)~~~~~~~~~~~~~~
if Flag_write_Movie == 1
    MakeQTMovie('framerate', fps);
    MakeQTMovie('finish');
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~


datafname='roboFig';
save_fig;


