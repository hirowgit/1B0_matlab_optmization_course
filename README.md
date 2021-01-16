# 1A_matlab_basic_course

 
# MATLAB Install
 There are  ways to use MATLAB codes as follows:

### 1) Matlab Online  
No installation into your PC physically, you can test codes in the web browser.  
https://www.mathworks.com/products/matlab-online.html  
Check your licence 
https://www.mathworks.com/products/matlab/student.html?s_tid=products_stu_version  
  
### 2) Trial licence for 30 days   
https://www.mathworks.com/campaigns/products/trials.highResolutionDisplay.html  
  
### 3) Comatible softwares  
#### * GNU Octave  
http://www.gnu.org/software/octave/  
  
#### * Scilab   
http://www.scilab.org/var/ezflow_site/storage/images/homepage_block_links/scilab/6583-1-fre-FR/  
  
Note: GNU Octave is more compatible with the original.  
  
# Lecture 1 
## example 1: draw a graph

figure(1); clf; t=0:0.1:2*pi; plot(t,sin(t));
 
 ## example 2:  iterate in a loop
k=0; <br>
for i=1:10<br>
  k=k+1;<br>
 disp(k);<br>
end<br> 
<br>
---output---<br>

 1

 2

 3

 4

 5

 6

 7

 8

 9

10

# Lecture1: deal with a matrix to plot a graph
https://github.com/hirowgit/1_matlab_basic_course

hirowgit/1_matlab_basic_course


 
# Step 1 
##  How to make a matrix.
Let us start the lecture. Think about a natural number like 1,2,3,4,… more.
In the first place, the programming is a kind of automation, or logical abstraction.
You can design a matrix like [1,2,3,4, ….. N], where N represents the termination, and name “a.” It can be treated as this code.
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step1.m#L34

lec1_step1.m:34
<pre><code>a=[1,2,3,4] </code></pre>
  
## The result is here.
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step1/lec1_step1.html#L71-L73

lec1_step1/lec1_step1.html:71-73
<pre><code>a = 1 2 3 4 </code></pre>
 
# Step 2 
##   Other matrix notation
Similarly it can be written as follows:
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step2.m#L33-L35

lec1_step2.m:33-35
<pre><code>
a1=[1,2,3,4] 

a2=[1:4] 

a3=[1:1:4] 
</code></pre>
  
## Here is the result.
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step2/lec1_step2.html#L73-L85

lec1_step2/lec1_step2.html:73-85
<pre><code>
a1 = 

 1 2 3 4 

a2 = 

 1 2 3 4 

a3 = 

 1 2 3 4 
</code></pre>
  
 
## Comment
All codes generate the same result but those meanings are different. The first one is the basic type, but you have to type every numbers. In the second one,  a kind of automation was realized, which means that you just type starting and ending numbers only. You can save your energy. The third case is an extension. You may have a further doubt when you see the second one. Thus,  “why does the number increase at intervals of “1” ? Yes, this is the right question. You can control the step by adding more “:” for example 1: 3: 15, or 0: 0.5: 10.

## Assignment 1-2:  
Make type matrices as even number (evennum) and odd numbers (oddnum).




# Step 3 
##  Display the result
According to the description rule of MATLAB, “;” represents termination of the single line code.
Therefore you usually type the code “;” at the end of the line to terminate, while the line works well without the termination code.
If you skip the code, the system outputs the result of the single line to the command line window.
This function is practically used for debugging. For example, if you find some error in the program, you can temporally remove the termination code to check calculation results prior to the target point when the error occurred.
Please compare the descriptions in  lec1step2.m (L33-L35) and lec1step3.m.

https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step3.m#L34-L41

lec1_step3.m:34-41
<pre><code>
a1=[1,2,3,4]; 

a2=[1:4]; 

a3=[1:1:4]; 


disp(a1); 

disp(a2);

disp(a3);
 </code></pre>
  
The function “disp” output the result to the command line window.

## Here is the result.
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step3/lec1_step3.html#L78-L80

lec1_step3/lec1_step3.html:78-80
<pre><code> 
1 2 3 4 

1 2 3 4 

1 2 3 4 
</code></pre>
  
However there is no description of each prefix like “a1 =“,  “a2 =” and “a3 =“. If you want to add some kind of descriptions about names of variables, you can add like disp([‘a1 = ’, a1]); Or fprintf(‘a1 = [%d %d %d %d]\r\n’,a), as C programming language style.
[‘a1 = ’, a1] means that a concatenation of two items into a matrix.

## Assignment 1-3:
  Explain the functional difference between fprintf(‘a1 = %d \r\n’,a) and fprintf(‘a1 = %d %d %d %d\r\n’,a), if a=[1 2 3 4].


## Assignment 1-4A:
In reference to the code lec1_step4.m generates a following matrix,

1.0000    2.0000    3.0000    4.0000    5.0000    6.0000    7.0000 … 10.0000<br>
 0.6499    0.8942    0.7904    0.0114    0.6350    0.0614    0.4116 … 0.7793<br>
<br>
modify the code to generate the matrix consisting of integer numbers, like<br>
1 2 3 4 …<br>
7 3 1 9 …<br>
by considering arithmetic operations with “rand” function without any other MATLAB functions except “round” and “floor” functions.

<br>
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step4.m#L34-L39

lec1_step4.m:34-39
<pre><code>
step=1:10; 

data=rand(1,length(step)); 

merged_data=[step; data]; 

disp(merged_data);
</code></pre>
  
## Assignment 1-4B:
With respect to a following matrix,<br>
<br>
1 2 3 4 …<br>
7 3 1 9 …<br>
<br>
make a program to sort by second line, such as<br>
3 2 1 4 …<br>
1 3 7 9 …<br>
<br>
by using “sortrows” function.<br>

https://www.mathworks.com/help/matlab/ref/double.sortrows.html

mathworks.com
Sort rows of matrix or table - MATLAB sortrows
This MATLAB function sorts the rows of a matrix in ascending order based on the elements in the first column.

# Step 5 
##  Plot data
This is an example to plot a sequential data, i.e. temporal sequence, with a modifiable step width  “dt.”
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step53.m#L34-L40

lec1_step53.m:34-40
<pre><code>
dt=0.01; 

t=0:dt:2*pi; 

figure(1); clf; 

plot(t,sin(t),'.-'); 

grid on; 

</code></pre>
  
## Here is the result.
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step53/lec1_step53_01.png

![lec1_step53_01.png](https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step53/lec1_step53_01.png "lec1_step53_01.png")
 
  
## Assignment 1-5A:
Analyze what happing around 0 if the target function is defined as sin(1/x) by changing the step in the horizontal axis.


# Step 6 
##  Plot data with noise
This is an example to plot a sequential data after adding noise, with a modifiable level of noise by “noise_level.”
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step63.m#L35-L44

lec1_step63.m:35-44
<pre><code>
dt=0.01;

noise_level=0.1; 

t=0:dt:2*pi; 

data=noise_level.*(rand(1,length(t)).*2-1); 

figure(1); clf; 

plot(t,sin(t),'b.-'), hold on; 

plot(t,data+sin(t),'r.'); grid on; 

</code></pre>
  
## Assignment 1-6A:
Explain the reason why arithmetic operations with “rand” function is necessary  in the case of “(rand(1,length(t)).2-1)”
*
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step63.m#L37

lec1_step63.m:37
<pre><code>data=noise_level.*(rand(1,length(t)).*2-1); </code></pre>
 
## Hint: 
compare the code “lec1_step62.m.”
https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step62/lec1_step62_01.png

![lec1_step62_01.png](https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step62/lec1_step62_01.png "lec1_step62_01.png")
 
  
## Assignment 1-6B:
Obtain the fitting curve from the output data “data=noise_level.(rand(1,length(t)).2-1);”
by using  “polyfit” MATLAB function (do not use other MATLAB functions) and then plot the result to compare the right answer as sin(x).


https://github.com/hirowgit/1_matlab_basic_course/blob/master/lec1_step63.m#L37-L38

lec1_step63.m:37-38
<pre><code>data=noise_level.*(rand(1,length(t)).*2-1); </code></pre>
 
## Hint: 
“polyfit” MATLAB function, Polynomial curve fitting
https://www.mathworks.com/help/matlab/ref/polyfit.html

mathworks.com
Polynomial curve fitting - MATLAB polyfit
This MATLAB function returns the coefficients for a polynomial p(x) of degree n that is a best fit (in a least-squares sense) for the data in y.
