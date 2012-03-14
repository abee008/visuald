// This file is part of Visual D
//
// Visual D integrates the D programming language into Visual Studio
// Copyright (c) 2010-2011 by Rainer Schuetze, All Rights Reserved
//
// License for redistribution is given by the Artistic License 2.0
// see file LICENSE for further details

module stdext.array;

T* contains(T)(T[] arr, bool delegate(ref T t) dg)
{
	foreach(ref T t; arr)
		if (dg(t))
			return &t;
	return null;
}

T* contains(T)(T[] arr, T val)
{
	foreach(ref T t; arr)
		if (t == val)
			return &t;
	return null;
}

int arrIndex(T)(in T[] arr, T val)
{
	for(int i = 0; i < arr.length; i++)
		if (arr[i] == val)
			return i;
	return -1;
}

int arrIndexPtr(T)(in T[] arr, T val)
{
	for(int i = 0; i < arr.length; i++)
		if (arr[i] is val)
			return i;
	return -1;
}

void addunique(T)(ref T[] arr, T val)
{
	if (!contains(arr, val))
		arr ~= val;
}

void addunique(T)(ref T[] arr, T[] vals)
{
	foreach(val; vals)
		if (!contains(arr, val))
			arr ~= val;
}

void remove(T)(ref T[] arr, T val)
{
	int idx = arrIndex(arr, val);
	if(idx >= 0)
		arr = arr[0..idx] ~ arr[idx+1..$];
}

///////////////////////////////////////////////////////////////////////

struct Set(T)
{
	bool[T] _payload;

	alias _payload this;

	T first()
	{
		foreach(n, b; _payload)
			return n;
		return null;
	}
}

bool contains(T)(ref bool[T] arr, T val)
{
	return (val in arr);
}

void addunique(T)(ref bool[T] arr, T val)
{
	arr[val] = true;
}

void addunique(T)(ref bool[T] arr, T[] vals)
{
	foreach(val; vals)
		arr[val] = true;
}

void addunique(T)(ref bool[T] arr, bool[T] vals)
{
	foreach(val, b; vals)
		arr[val] = true;
}

// needed in dmd 2.058beta
//version(none):
void addunique(T)(ref Set!T arr, T val)
{
	arr[val] = true;
}

void addunique(T)(ref Set!T arr, bool[T] vals)
{
	foreach(val, b; vals)
		arr[val] = true;
}

void remove(T)(ref bool[T] arr, T val)
{
	arr.remove(val);
}
