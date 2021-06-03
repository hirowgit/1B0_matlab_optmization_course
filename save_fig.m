%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2014 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
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
% # @Time    : 2014-08-09 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1B1_matlab_signal_analysis_course
% # @IDE     : MATLAB R2018a
% # @File    : save_fig.m

%%  Sub program

folder_name=strsplit(datafname,'.');
if ~exist(folder_name{1},'dir'); mkdir(folder_name{1}); end
curdir=pwd;
cd(folder_name{1});

hfig=findobj('Type','figure');
for i=1:length(hfig)
    sname=get(hfig(i),'name'); s2name = regexp(sname,'[A-Za-z0-9()]+','match'); 
    if isempty(s2name) fnlname=['fig_',num2str(hfig(i))]; else fnlname='fig'; end 
    fnlname=[fnlname,'_',folder_name{1}];
    for j=1:length(s2name)
        fnlname=[fnlname,'_',s2name{j}];
    end
    figure(hfig(i));
    saveas(gcf,fnlname,'fig');
    saveas(gcf,fnlname,'pdf');
%     saveas(gcf,fnlname,'ai');
    saveas(gcf,fnlname,'eps');
    saveas(gcf,fnlname,'jpg');
    saveas(gcf,fnlname,'png');
end
cd(curdir);