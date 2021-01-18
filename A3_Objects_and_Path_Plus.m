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
% # @Time    : 2021-1-16 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B0_matla_optmization_course
% # @IDE     : MATLAB R2018a
% # @File    : A3_Objects_and_Path_Plus.m

%%  Main program
% clear all
clc

A1_ExcelRead_and_Plot_Normal;

contr=[-0.15,0.15,0.7,0.7,-0.7,-0.7,-0.15,-0.15,0.15,0.15;1,1,1,-1,-1,1,1,-1,-1,1];
gAng=@(x1,y1,x2,y2) atan2(y2-y1,x2-x1);
RotM=@(theta) [cos(theta),-sin(theta);sin(theta),cos(theta)];

% Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);


% ~~~~~~~~~MakeQTMovie <initialize> (start)~~~~~~~~~~~~~~
% You need to place "MakeQTMovie.m" (c) Copyright Malcolm Slaney, Interval Research, March 1999.
% in the same folder of this file

Flag_write_Movie=1; 
Nm=1; % the serial number of the movie 
f_folder='movie'; % the output folder of the movie
if ~isdir(f_folder); mkdir(f_folder); end
f_prefix='outputMoviePathM_c_'; % the output file name
if Flag_write_Movie == 1
    MovieFileName = strcat(f_prefix,num2str(Nm),'.mov'); 
    fprintf('Creating the movie file %s.\n', fullfile(f_folder,MovieFileName));
    MakeQTMovie('start',fullfile(f_folder,MovieFileName));
    MakeQTMovie('size', [480 360]);
    MakeQTMovie('quality', 1.0);
%     fps = 10; 
  fps = 30;
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~

xRange=[50 200];
yRange=[50 200];
cmap1=colormap('Lines');

figure(4); clf
Dlen=[];
for i=1:Lsize
    sTraj_full=lineD2{i};
    Dlen(i)=length(sTraj_full);
    pp0{i}=plot(sTraj_full(:,1),sTraj_full(:,2),'.-','lineWidth',2,'MarkerSize',20); hold on;
%     pp0{i}=plot(sTraj_full(:,1),sTraj_full(:,2),'k-'); hold on;
    axis equal; grid on; xlabel('x'); ylabel('y');
    grid on;
    title(['Object movements in the trajectory ']);
    
    xx=1:size(contr,2);
    pp1{i}=plot(xx,xx,'Color',cmap1(i,:),'lineWidth',2); 
%     set(pp{i},'erasemode','xor');

    set(gca,'xlim',xRange,'ylim',yRange);
end
Dlim=min(Dlen);

for k=1:Dlim-1
    
    for i=1:Lsize
        sTraj_full=lineD2{i};        
        x1=sTraj_full(k,1); y1=sTraj_full(k,2);
        x2=sTraj_full(k+1,1); y2=sTraj_full(k+1,2);
        Pcontr=RotM(gAng(x1,y1,x2,y2))*contr+repmat([x1;y1],[1,size(contr,2)]);
        
        set(pp1{i},'XData',Pcontr(1,:),'YData',Pcontr(2,:));
%         plot(Pcontr(1,:),Pcontr(2,:),'.-','lineWidth',2,'MarkerSize',20),hold on;


        % ~~~~~~~~~MakeQTMovie <add a frame> (start)~~~~~~~~~~~~~~
        if Flag_write_Movie == 1
            MakeQTMovie('addfigure');
        end
        % ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~

    %     pause(0.2);
    %     drawnow;
%         hold off
    end
end

% ~~~~~~~~~MakeQTMovie  <finalize> (start)~~~~~~~~~~~~~~
if Flag_write_Movie == 1
    MakeQTMovie('framerate', fps);
    MakeQTMovie('finish');
    strMessage=sprintf('Please find the generated mov file in the folder "%s" as filename "%s"',f_folder,MovieFileName);
    disp(strMessage);
end
% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~




% ~~~~~~~~~MakeQTMovie <comment>~~~~~~~~~~~~~~
% The generated mov file is recommended to open QuickTime Player 7 in the first place and resave a new mov file by the player.
% The new mov file generated by the player can be opened with a recent version of the QuickTime Player.

% ~~~~~~~~~MakeQTMovie (end)~~~~~~~~~~~~~~
