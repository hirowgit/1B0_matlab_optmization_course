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
% # @File    : A1_ExcelRead_and_Plot_Normal.m

%%  Main program
% clear all;
clc

dataF='output';
fname='to_csv2.csv';
dname='Mdat';

Mdat=readtable(fullfile(dataF,fname));
lineD={};

Mdat.Properties
size(Mdat)
varnames=Mdat.Properties.VariableNames;
varnames
j=1;
Lsize=(size(Mdat,2)-1)/2;
for k=1:Lsize
    strLx=['x',num2str(k),'=',dname,'.',varnames{k*2}];
    strLy=['y',num2str(k),'=',dname,'.',varnames{k*2+1}];
    eval(strLx); eval(strLy);
    
    strLx=['lineD{',num2str(k),'}(:,1)=',dname,'.',varnames{k*2}];
    strLy=['lineD{',num2str(k),'}(:,2)=',dname,'.',varnames{k*2+1}];
    eval(strLx); eval(strLy);
    
end

for k=1:Lsize
    Dedge=find(lineD{k}(:,1)>0 & lineD{k}(:,1)>0);
    mD=max(Dedge);
    lineD2{k}=[lineD{k}(1:mD,1) lineD{k}(1:mD,2)];
%     lineD{k}(:,1)=find(lineD{k}(:,1)
end

figure(1); clf
colM=colormap(lines(Lsize));
for k=1:Lsize
    pdata=lineD2{k};
    plot(pdata(:,1),pdata(:,2),'color',colM(k,:),'LineWidth',2), hold on;
end
myXlim=get(gca,'xlim'); myYlim=get(gca,'ylim');
set(gca,'xlim',myXlim+[-10 10],'ylim',myYlim+[-10 10]);
grid on; xlabel('x','FontSize',12); ylabel('y','FontSize',12)