#pragma once
#include <assert.h>
#include <stdio.h>

//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
//	��������꣬����������Ƚ�
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

/* ���ԱȽϣ����û�ָ��������Ϊ�٣�0�������쳣��ֹ���򡣿����ڷ��а汾���á� */
void _Assert_assert(int max, int min)
{
	assert(max > min);
}
/* ��̬���ԱȽϣ�����ʱ���� */
void _Assert_Static_assert()
{
	static_assert(sizeof(int) == 4, "Int Size is not 4 Bits");
}