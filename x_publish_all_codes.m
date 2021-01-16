%% MATLAB programming course for beginners, supported by Wagatsuma Lab@Kyutech 
%
% /* 
% The MIT License (MIT): 
% Copyright (c) 2020 Hiroaki Wagatsuma and Wagatsuma Lab@Kyutech
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
% # @Time    : 2020-4-20 
% # @Author  : Hiroaki Wagatsuma
% # @Site    : https://github.com/hirowgit/1_matlab_basic_course
% # @IDE     : MATLAB R2018a
% # @File    : x_publish_all_codes.m

%% Main program
%% Get all file names in the target folder
dirflist=dir; 

%% Data structure transformation
% matlab struct data (obtained list data by "dir" command) to single list as cell that only contains file names

rfields = fieldnames(dirflist); keyST=cell(size(rfields)); keyST(:,:)={'name'};
keynum=cell2mat(cellfun(@(x1,x2) ~contains(x1,x2), rfields, keyST,'UniformOutput',false)); 
% if you have past version of matlab or compatible software, you can use
% "isempty" function instead such as:
% keynum=cell2mat(cellfun(@(x1,x2) isempty(strfind(x1,x2)), rfields, keyST,'UniformOutput',false));
flist=struct2cell(rmfield(dirflist,rfields(keynum))); 

%% Purification of target data
% extract matlab running codes denoted as ".m" file and remove similar file
% like ".mat" (matlab data file) and then remove other codes such as codes to publish. 
% (an endless loop will be happing if the program requests to publish a code including "publish" inside)

keyST=cell(size(flist)); keyRemove=keyST; keyST(:,:)={'.m'}; keyRemove(:,:)={[".mat","x_"]};
keynum=cell2mat(cellfun(@(x1,x2,x3) contains(x1,x2)&~contains(x1,x3), flist, keyST,keyRemove,'UniformOutput',false));
flist2=flist(keynum);

%% Publication of all matlab running codes
% run "publish" for making html and pdf files to explain individual matlab program 

for i=1:length(flist2)
    disp(i);
    getTag=strsplit(flist2{i},'.');
    this_file_tag=getTag{1};
    x_publish_all_codes_sub;
end

