/* long
comment long
comment */

function bool foo1(int a, b, y; char c)
{
	var bool res = true;
	{
		var char x = 'd', b;
		var int y;
		b = '&';
		a = (y * 7)/a-y;
		res = (b == c) && (y > a);
	}
    	return res ;
}


function void fee1(int i, j, k, x)
{
    function bool fee2(int l, m, n)
    {
	var bool x, j; /* declarations */
	var char k;
	k = '@'; /* statements */
	i = l + l;
	if ((k == '*') || (x != false) && (l + m < i)){
		x = l < m;
	}
        return x;
    }
    {
	var char x;
	var bool k;
	k = fee2(5,i,j);
     }
    x = k;
}



function int foo2()
{
    string s1[100]="aba", s2[40], s3[20]="";
    var int i, j=0, cnt;
    cnt = 1;
    for(i=0; i<|s1|; i=i+1){
	do{
	    if (s1[i] == s2[j])
		cnt = cnt*2;
	    j=j+1;
	}while(j<|s2|/2);
	j=i*2;
    }
    return cnt;
}


function int foo4()
{
    {   
	var int x;
	var int* y;
	x = 5;
	y = &x;
	x = 6;
	if (&x == y && *y == x)
		*y = 9;
     	{
		var char* x;
		string y[10];
		var char z;
		y = "foobar";
		x = &y[5];         
		z = *(x - 5);       
		y = "barfoo"; 
	}
     }
    return 0;
}



function void main()
{
    var int a;
    a = foo2();
}