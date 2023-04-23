transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/parteIII.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/cache2vias.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/sistema.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/extensor3para8.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/controleCache.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/memoriaram.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/decodificador.v}

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada\ -\ controlecache {C:/altera/13.0sp1/QuartusProjects/LAOC_II/Atividade01/Pratica03_centrada - controlecache/tb_parteIII.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  tb_parteIII

add wave *
view structure
view signals
run -all
