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
% # @File    : R1_state_gen_Palladium.m
 
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
set(fignum,'Position',[560   500   800   450]); hold on;

spbtn = uicontrol('Style','pushbutton','Units','normalized',...
        'Position',[.93  .2  .05  .1],'String','Stop it');
set(spbtn,'interruptible','on','Callback','itr = 0;');
set(98,'doublebuffer','on');
set(99,'doublebuffer','on');
set(gca,'drawmode','fast');
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pauseT=0.3;
% pauseT=0.03;
pauseT=0.1;
% ~~~~~~~~~MakeQTMovie <initialize> (start)~~~~~~~~~~~~~~
% You need to place "MakeQTMovie.m" (c) Copyright Malcolm Slaney, Interval Research, March 1999.
% in the same folder of this file

Flag_write_Movie=1; 
Nm=5;
pbackN=5;
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
    key(pID,:)=postureR(pID,:)+(([1:posRd]-1)*size(xD,1));
    set(pp,'XData',xDf(key(pID,:)),'YData',yDf(key(pID,:)));
    for j=grip(pID,:)        
        set(pp2,'XData',handS(1,:,j)+xDf(key(pID,end)),'YData',handS(2,:,j)+yDf(key(pID,end)));
        
        % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        else
            pause(pauseT);
        end
      % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
        drawnow;
    end
    if exOb(pID)
        tlabel='no object';
        set(tStatus,'Position',tlabelPos-[1.2*flenS*length(tlabel) 0],'String',tlabel);
        for j=grip(pID,:)        
            set(pp2,'XData',handS(1,:,j)+xDf(key(pID,end)),'YData',handS(2,:,j)+yDf(key(pID,end)));
        
    % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        else
            pause(pauseT./3);
        end
     % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
            drawnow;
        end
    else
        tlabel='pick successfully';
        key(pID,:)=postureR_pick(pID,:)+(([1:posRd]-1)*size(xD,1));
        set(pp,'XData',xD_pick(key(pID,:)),'YData',yDf_pick(key(pID,:)));
        j=grip(pID,2);       
        set(pp2,'XData',handS(1,:,j)+xD_pick(key(pID,end)),'YData',handS(2,:,j)+yDf_pick(key(pID,end)));
        set(pp3{pID},'YData',obYpos(k)+upH);
         
    % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        else
            pause(pauseT);
        end
     % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~        
     drawnow;
    end
    if itr==0; break; end  
end

label={'container','box1','box2','launch_box','area1','area2','robot','robot_j1','robot_j2','robot_j3','hand','object1','object2','initial_state','final_state'};

statelabel={'hand_state','hand_pos','container','launch_box'};
stateL={'grab','pos','box','area'};
stateNum=[1,4,2,2]; % true/false =1;

f_read_numlength=2;
nadd=strrep(num2str(zeros(1,f_read_numlength)),'  ','');
expandState={};
for k=1:length(stateNum)
    if stateNum(k)>1
        numc={};
        for j=1:stateNum(k)
            regnum=[nadd(1:(length(nadd)-length(j))),num2str(j)];
            numc(j)={regnum};
        end
        tempS2=cell(1,stateNum(k));
        tempS2(:)={stateL{k}};
        tempS3=cell2mat(cellfun(@(x,y) [x,y],tempS2,numc,'UniformOutput',false)');
        strC=cellstr(tempS3);
    else
        strC={stateL{k}};
    end
    if ~isempty(expandState) 
        expandState(end+1:end+length(strC))=strC; 
    else
        expandState=strC; 
    end   
end

obYpos=posObj(2,:)-2;
for k=1:size(postureR,1)
    set(pp3{k},'YData',obYpos(k),'Color',obSet(obSt(k),:));
end

itr=1;
% ~~~~~~~~~~~~~~~~~~~~
eSf=false(1,length(expandState));
% ~~~~~~~~~~~~~~~~~~~~
fsize=22; flenS=0.0035*fsize;
ttPosX=[1:length(expandState)]*1.05;
ttPosX=ttPosX-mean(ttPosX);
ttPosY=6*ones(1,length(expandState));
ttPos=[ttPosX; ttPosY];

tlabel=num2str(eSf);
for k=1:length(expandState)
    tlabel=expandState{k};
    text(ttPosX(k)-1.2*flenS*length(tlabel),ttPosY(k),tlabel);
end

f_read_numlength=length(expandState);
nadd=strrep(num2str(zeros(1,f_read_numlength)),'  ','');

for kL=0:power(2,length(expandState))-1
    eSf=false(1,9);
    binStr = dec2bin(kL);
    binStr2=fliplr([nadd(1:(length(nadd)-length(j))),binStr]);
    kL
    binStr
    ef=logical(str2num(cell2mat(cellstr(binStr2'))))';
    if length(ef)>9; ef=ef(1:9); end
    eSf(1:length(ef))=ef;
    
    tlabel=num2str(eSf);
    tlabel=strrep(tlabel,' ','   ');
    set(tStatus,'Position',tlabelPos-[1.2*flenS*length(tlabel)-0.7 0],'String',tlabel,'FontSize',fsize);
    
    defPos=[1:4]*2-1;
    defCol=repmat([2 3],[1 2])';
    obSet2=obSet(defCol,:);
    % eSf(6:9)=true(1,4);

    for k=6:9
        k2=k-6+1;
        if eSf(k)
            set(pp3{defPos(k2)},'YData',obYpos(defPos(k2))+2*eSf(k),'Color',obSet2(k2,:));
        else
           set(pp3{defPos(k2)},'YData',obYpos(defPos(k2))+2*eSf(k),'Color',obSet2(k2,:)); 
        end
    end

    % eSf(2:5)=true(1,4);
    for k=2:5
    % k=1
        k2=k-2+1;
        if eSf(k)
            pID=defPos(k2);
            set(pp,'XData',xDf(key(pID,:)),'YData',yDf(key(pID,:)));
            for j=1:2
                set(pp2,'XData',handS(1,:,j)+xDf(key(pID,end)),'YData',handS(2,:,j)+yDf(key(pID,end)));
            % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
                if Flag_write_Movie == 1
                    MakeQTMovie('addfigure');
                else
                    pause(pauseT);
                end
             % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~   
             drawnow;
            end

        end
    end

    % eSf(1)=true;
    if eSf(1)
            for j=1:3
                set(pp2,'XData',handS(1,:,j)+xDf(key(pID,end)),'YData',handS(2,:,j)+yDf(key(pID,end)));
            % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
                if Flag_write_Movie == 1
                    MakeQTMovie('addfigure');
                else
                    pause(pauseT);
                end
             % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~   
             drawnow;
            end
    else
         for j=1:2
                set(pp2,'XData',handS(1,:,j)+xDf(key(pID,end)),'YData',handS(2,:,j)+yDf(key(pID,end)));
            % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
                if Flag_write_Movie == 1
                    MakeQTMovie('addfigure');
                else
                    pause(pauseT);
                end
             % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~   
             drawnow;
         end
    end
     if itr==0; break; end  
       
end
        
        
        
% ~~~~~~~~~MakeQTMovie  <finalize> (start)~~~~~~~~~~~~~~
if Flag_write_Movie == 1
    MakeQTMovie('framerate', fps);
    MakeQTMovie('finish');
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~

datafname='roboFig5';
save_fig;

