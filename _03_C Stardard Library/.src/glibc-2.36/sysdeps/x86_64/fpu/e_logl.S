/*
 * Public domain.
 *
 */

#include <machine/asm.h>
#include <libm-alias-finite.h>

	.section .rodata.cst8,"aM",@progbits,8

	.p2align 3
	.type one,@object
one:	.double 1.0
	ASM_SIZE_DIRECTIVE(one)
	/* It is not important that this constant is precise.  It is only
	   a value which is known to be on the safe side for using the
	   fyl2xp1 instruction.  */
	.type limit,@object
limit:	.double 0.29
	ASM_SIZE_DIRECTIVE(limit)


#ifdef PIC
# define MO(op) op##(%rip)
#else
# define MO(op) op
#endif

	.text
ENTRY(__ieee754_logl)
	fldln2			// log(2)
	fldt	8(%rsp)		// x : log(2)
	fxam
	fnstsw
	fld	%st		// x : x : log(2)
	testb	$1, %ah
	jnz	3f		// in case x is NaN or +-Inf
	movzwl	8+8(%rsp), %eax
	cmpl	$0xc000, %eax
	jae	6f		// x <= -2, avoid overflow from -LDBL_MAX - 1.
4:	fsubl	MO(one)		// x-1 : x : log(2)
6:	fld	%st		// x-1 : x-1 : x : log(2)
	fabs			// |x-1| : x-1 : x : log(2)
	fcompl	MO(limit)	// x-1 : x : log(2)
	fnstsw			// x-1 : x : log(2)
	andb	$0x45, %ah
	jz	2f
	fxam
	fnstsw
	andb	$0x45, %ah
	cmpb	$0x40, %ah
	jne	5f
	fabs			// log(1) is +0 in all rounding modes.
5:	fstp	%st(1)		// x-1 : log(2)
	fyl2xp1			// log(x)
	ret

2:	fstp	%st(0)		// x : log(2)
	fyl2x			// log(x)
	ret

3:	testb	$4, %ah
	jnz	4b		// in case x is +-Inf
	fstp	%st(1)
	fstp	%st(1)
	fadd	%st(0)
	ret
END (__ieee754_logl)


ENTRY(__logl_finite)
	fldln2			// log(2)
	fldt	8(%rsp)		// x : log(2)
	fld	%st		// x : x : log(2)
	fsubl	MO(one)		// x-1 : x : log(2)
	fld	%st		// x-1 : x-1 : x : log(2)
	fabs			// |x-1| : x-1 : x : log(2)
	fcompl	MO(limit)	// x-1 : x : log(2)
	fnstsw			// x-1 : x : log(2)
	andb	$0x45, %ah
	jz	2b
	fxam
	fnstsw
	andb	$0x45, %ah
	cmpb	$0x40, %ah
	jne	7f
	fabs			// log(1) is +0 in all rounding modes.
7:	fstp	%st(1)		// x-1 : log(2)
	fyl2xp1			// log(x)
	ret
END (__logl_finite)
libm_alias_finite (__logl_finite, __logl)
