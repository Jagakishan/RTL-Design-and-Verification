/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_23(char*, char *);
IKI_DLLESPEC extern void execute_51(char*, char *);
IKI_DLLESPEC extern void execute_52(char*, char *);
IKI_DLLESPEC extern void execute_53(char*, char *);
IKI_DLLESPEC extern void execute_58(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_65(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void execute_67(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
IKI_DLLESPEC extern void execute_46(char*, char *);
IKI_DLLESPEC extern void execute_48(char*, char *);
IKI_DLLESPEC extern void execute_49(char*, char *);
IKI_DLLESPEC extern void execute_50(char*, char *);
IKI_DLLESPEC extern void execute_60(char*, char *);
IKI_DLLESPEC extern void execute_61(char*, char *);
IKI_DLLESPEC extern void execute_62(char*, char *);
IKI_DLLESPEC extern void execute_63(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_75(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_77(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_87(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_88(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_93(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_94(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_95(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_96(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_100(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_101(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_102(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_103(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_104(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_105(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_108(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_109(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void transaction_110(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[42] = {(funcp)execute_23, (funcp)execute_51, (funcp)execute_52, (funcp)execute_53, (funcp)execute_58, (funcp)execute_64, (funcp)execute_65, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_46, (funcp)execute_48, (funcp)execute_49, (funcp)execute_50, (funcp)execute_60, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_72, (funcp)execute_73, (funcp)execute_74, (funcp)execute_75, (funcp)execute_76, (funcp)execute_77, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_87, (funcp)transaction_88, (funcp)transaction_93, (funcp)transaction_94, (funcp)transaction_95, (funcp)transaction_96, (funcp)vlog_transfunc_eventcallback_2state, (funcp)transaction_100, (funcp)transaction_101, (funcp)transaction_102, (funcp)transaction_103, (funcp)transaction_104, (funcp)transaction_105, (funcp)transaction_108, (funcp)transaction_109, (funcp)transaction_110};
const int NumRelocateId= 42;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/constrained_tb_behav/xsim.reloc",  (void **)funcTab, 42);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/constrained_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(12, 5160, 2,2, 0, 32,5344, 3,0,0,4976, 2,2, 0, 32,6080, -7,0,7840, 18,0,0,5712, 11,0,0,8024, 19,0,0,5896, 11,0,0,7472, 16,0,0,5528, 11,0,0,6776, -7,0,7656, 17,0,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/constrained_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void subprog_m_3d442498_9249fcdd_29() ;
void subprog_m_3d442498_9249fcdd_28() ;
void subprog_m_3d442498_9249fcdd_27() ;
void subprog_m_3d442498_9249fcdd_26() ;
void subprog_m_3d442498_9249fcdd_25() ;
void subprog_m_3d442498_9249fcdd_24() ;
void subprog_m_3d442498_9249fcdd_23() ;
static char* ng120[] = {(void *)subprog_m_3d442498_9249fcdd_29, (void *)subprog_m_3d442498_9249fcdd_28, (void *)subprog_m_3d442498_9249fcdd_27, (void *)subprog_m_3d442498_9249fcdd_26, (void *)subprog_m_3d442498_9249fcdd_25, (void *)subprog_m_3d442498_9249fcdd_24, (void *)subprog_m_3d442498_9249fcdd_23};
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_xsimdir_location_if_remapped(argc, argv)  ;
    iki_set_sv_type_file_path_name("xsim.dir/constrained_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/constrained_tb_behav/xsim.crvsdump");
    iki_svlog_initialize_virtual_tables(1, 12, ng120);
    void* design_handle = iki_create_design("xsim.dir/constrained_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
