#pragma once
// Compile with /std:c11
#include <stdarg.h>
#include <stdio.h>
#include "Utils.h"

//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
//	�����ɱ��������
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

/* �ɱ�������ʰ������ɱ�����б����͵�˳�������֪��int��double�� */
void _Stdarg_VarParams(int preParam, ...)
{
	va_list args, cargs;
	va_start(args, preParam);
	printf("���յ� Int:%d\n", va_arg(args, int));
	va_copy(cargs, args);	// ���Ƶ�ǰ״̬�µ� args
	printf("���յ� Double:%.2f\n", va_arg(args, double));
	va_end(args);
	printf("���յ� Copy Double:%.2f\n", va_arg(cargs, double));
	va_end(cargs);
}