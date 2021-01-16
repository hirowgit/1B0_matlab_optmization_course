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
% # @File    : lec1_step65.m

%%  Main program

dt=0.01; noise_level=0.1;
t=0:dt:2*pi;
dataUpper=noise_level.*rand(1,length(t));
dataUpDown=noise_level.*(rand(1,length(t)).*2-1);

figure(1); clf;
subplot(3,1,1);
plot(t,sin(t),'b.-'), hold on;

plot(t,dataUpper+sin(t),'r.');
grid on;


subplot(3,1,2);
% figure(3); clf;
plot(t,dataUpper,'.','MarkerSize',15);
ylabel('data','FontSize',14);
xlabel('time','FontSize',14);
set(gca,'ylim',[0 noise_level],'FontSize',14,'Color',[1 1 0],'FontName','Helvetica');

subplot(3,1,3);
% figure(3); clf;
plot(t,dataUpDown,'.','MarkerSize',15);


%% Supplementary information to publish
%
% If you want to make a pdf or html file on the code, 
% you can use the code "x_publish_each_codes.m" in the same folder. 
% Please change the file name as " this_file_tag='lec*_step*' "  
% (* will be replaced to the number of the target file). 
%
% The code "x_publish_all_codes.m" works for such a publication applying to all
% codes in the same folder (Note: "x_publish_all_codes_sub.m" should be located in the same folder).
%%