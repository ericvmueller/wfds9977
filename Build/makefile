# Makefile for WFDS (FDS6 r9977-based)
#
# GNU / Intel builds for macOS and Linux. Build from a target directory, e.g.:
#
#   cd Build/ompi_gnu_osx      && ./make_fds.sh
#   cd Build/ompi_gnu_linux    && ./make_fds.sh
#   cd Build/impi_intel_linux  && ./make_fds.sh
#
# Targets:
#   gnu_osx[_db|_dv]          ompi_gnu_osx[_db|_dv]
#   gnu_linux[_db|_dv]        ompi_gnu_linux[_db|_dv]
#   intel_linux[_db|_dv]      impi_intel_linux[_db|_dv]
#                             ompi_intel_linux[_db|_dv]
#
# Intel oneAPI defaults (classic ifort/icc still work via make_fds.sh fallback)
# Override explicitly if needed: make FCOMPL=mpiifort CCOMPL=icc ...

VPATH = ../SourceFiles

objf_serial = prec.o mpis.o smvv.o cons.o devc.o data.o type.o mesh.o func.o irad.o \
             ieva.o pois.o scrc.o radi.o evac.o part.o vege.o ctrl.o turb.o geom.o dump.o hvac.o read.o \
             mass.o wall.o fire.o divg.o init.o velo.o pres.o main.o
obj_serial = isob.o $(objf_serial)

objf_mpi = prec.o mpip.o smvv.o cons.o devc.o data.o type.o mesh.o func.o irad.o \
          ieva.o pois.o scrc.o radi.o evac.o part.o vege.o ctrl.o turb.o geom.o dump.o hvac.o read.o \
          mass.o wall.o fire.o divg.o init.o velo.o pres.o main.o
obj_mpi = isob.o $(objf_mpi)

# Common gfortran flags needed for this vintage source on modern GCC
# -fallow-argument-mismatch: legacy MPI calls pass differently typed buffers
GFORTRAN_BASE = -ffree-line-length-none -frecord-marker=4 -fall-intrinsics -fallow-argument-mismatch
# pp_OSX: skip malloc.h on macOS. Do not set pp_noappend with gfortran —
# gfortran appends underscores, matching the default names in isob.c.
CFLAGS_OSX = -Dpp_OSX

no_target:
	@echo ******** You did not specify a make target ********
	@echo Please read the comments at the top of the makefile

setup:
%.o : %.mod

.SUFFIXES: .c .f90 .o

.f90.o:
	$(FCOMPL) -c $(FFLAGS) $<
.c.o:
	$(CCOMPL) -c $(CFLAGS) $<

# *** Serial GNU OSX ***

gnu_osx : FFLAGS = -O3 $(GFORTRAN_BASE)
gnu_osx : CFLAGS = -O3 $(CFLAGS_OSX)
gnu_osx : FCOMPL = gfortran
gnu_osx : CCOMPL = gcc
gnu_osx : LFLAGS = -static-libgfortran -static-libquadmath
gnu_osx : obj = wfds_gnu_osx
gnu_osx : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

gnu_osx_db : FFLAGS = -O0 -ggdb -Wall -Wsurprising -Wcharacter-truncation -fcheck=all -fbacktrace -ffpe-trap=invalid,zero,overflow $(GFORTRAN_BASE)
gnu_osx_db : CFLAGS = -O0 -g $(CFLAGS_OSX)
gnu_osx_db : FCOMPL = gfortran
gnu_osx_db : CCOMPL = gcc
gnu_osx_db : LFLAGS = -static-libgfortran -static-libquadmath
gnu_osx_db : obj = wfds_gnu_osx_db
gnu_osx_db : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

gnu_osx_dv : FFLAGS = -O1 -fbacktrace $(GFORTRAN_BASE)
gnu_osx_dv : CFLAGS = -O1 -g $(CFLAGS_OSX)
gnu_osx_dv : FCOMPL = gfortran
gnu_osx_dv : CCOMPL = gcc
gnu_osx_dv : LFLAGS = -static-libgfortran -static-libquadmath
gnu_osx_dv : obj = wfds_gnu_osx_dv
gnu_osx_dv : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

# *** Serial GNU Linux ***

gnu_linux : FFLAGS = -O3 $(GFORTRAN_BASE)
gnu_linux : CFLAGS = -O3
gnu_linux : FCOMPL = gfortran
gnu_linux : CCOMPL = gcc
gnu_linux : LFLAGS = -static-libgfortran -static-libquadmath
gnu_linux : obj = wfds_gnu_linux
gnu_linux : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

gnu_linux_db : FFLAGS = -O0 -ggdb -Wall -Wsurprising -Wcharacter-truncation -fcheck=all -fbacktrace -ffpe-trap=invalid,zero,overflow $(GFORTRAN_BASE)
gnu_linux_db : CFLAGS = -O0 -g
gnu_linux_db : FCOMPL = gfortran
gnu_linux_db : CCOMPL = gcc
gnu_linux_db : LFLAGS = -static-libgfortran -static-libquadmath
gnu_linux_db : obj = wfds_gnu_linux_db
gnu_linux_db : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

gnu_linux_dv : FFLAGS = -O1 -fbacktrace $(GFORTRAN_BASE)
gnu_linux_dv : CFLAGS = -O1 -g
gnu_linux_dv : FCOMPL = gfortran
gnu_linux_dv : CCOMPL = gcc
gnu_linux_dv : LFLAGS = -static-libgfortran -static-libquadmath
gnu_linux_dv : obj = wfds_gnu_linux_dv
gnu_linux_dv : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

# *** OpenMPI GNU OSX ***

ompi_gnu_osx : FFLAGS = -O3 $(GFORTRAN_BASE)
ompi_gnu_osx : CFLAGS = -O3 $(CFLAGS_OSX)
ompi_gnu_osx : FCOMPL = mpifort
ompi_gnu_osx : CCOMPL = mpicc
ompi_gnu_osx : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_osx : obj = wfds_ompi_gnu_osx
ompi_gnu_osx : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_gnu_osx_db : FFLAGS = -O0 -ggdb -Wall -Wsurprising -Wcharacter-truncation -fcheck=all -fbacktrace -ffpe-trap=invalid,zero,overflow $(GFORTRAN_BASE)
ompi_gnu_osx_db : CFLAGS = -O0 -g $(CFLAGS_OSX)
ompi_gnu_osx_db : FCOMPL = mpifort
ompi_gnu_osx_db : CCOMPL = mpicc
ompi_gnu_osx_db : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_osx_db : obj = wfds_ompi_gnu_osx_db
ompi_gnu_osx_db : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_gnu_osx_dv : FFLAGS = -O1 -fbacktrace $(GFORTRAN_BASE)
ompi_gnu_osx_dv : CFLAGS = -O1 -g $(CFLAGS_OSX)
ompi_gnu_osx_dv : FCOMPL = mpifort
ompi_gnu_osx_dv : CCOMPL = mpicc
ompi_gnu_osx_dv : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_osx_dv : obj = wfds_ompi_gnu_osx_dv
ompi_gnu_osx_dv : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

# *** OpenMPI GNU Linux ***

ompi_gnu_linux : FFLAGS = -O3 $(GFORTRAN_BASE)
ompi_gnu_linux : CFLAGS = -O3
ompi_gnu_linux : FCOMPL = mpifort
ompi_gnu_linux : CCOMPL = mpicc
ompi_gnu_linux : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_linux : obj = wfds_ompi_gnu_linux
ompi_gnu_linux : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_gnu_linux_db : FFLAGS = -O0 -ggdb -Wall -Wsurprising -Wcharacter-truncation -fcheck=all -fbacktrace -ffpe-trap=invalid,zero,overflow $(GFORTRAN_BASE)
ompi_gnu_linux_db : CFLAGS = -O0 -g
ompi_gnu_linux_db : FCOMPL = mpifort
ompi_gnu_linux_db : CCOMPL = mpicc
ompi_gnu_linux_db : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_linux_db : obj = wfds_ompi_gnu_linux_db
ompi_gnu_linux_db : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_gnu_linux_dv : FFLAGS = -O1 -fbacktrace $(GFORTRAN_BASE)
ompi_gnu_linux_dv : CFLAGS = -O1 -g
ompi_gnu_linux_dv : FCOMPL = mpifort
ompi_gnu_linux_dv : CCOMPL = mpicc
ompi_gnu_linux_dv : LFLAGS = -static-libgfortran -static-libquadmath
ompi_gnu_linux_dv : obj = wfds_ompi_gnu_linux_dv
ompi_gnu_linux_dv : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

# *** Serial Intel Linux ***
# -Dpp_noappend: Intel Fortran does not append underscores (matches isob.c)

intel_linux : FFLAGS = -O2 -ipo -no-wrap-margin
intel_linux : CFLAGS = -O -Dpp_noappend
intel_linux : FCOMPL = ifx
intel_linux : CCOMPL = icx
intel_linux : LFLAGS = -static-intel
intel_linux : obj = wfds_intel_linux
intel_linux : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

intel_linux_db : FFLAGS = -check all -warn unused -O0 -auto -WB -traceback -g -fpe0 -no-wrap-margin
intel_linux_db : CFLAGS = -g -Dpp_noappend
intel_linux_db : FCOMPL = ifx
intel_linux_db : CCOMPL = icx
intel_linux_db : LFLAGS = -static-intel
intel_linux_db : obj = wfds_intel_linux_db
intel_linux_db : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

intel_linux_dv : FFLAGS = -warn unused -O1 -g -traceback -no-wrap-margin
intel_linux_dv : CFLAGS = -O1 -g -Dpp_noappend
intel_linux_dv : FCOMPL = ifx
intel_linux_dv : CCOMPL = icx
intel_linux_dv : LFLAGS = -static-intel
intel_linux_dv : obj = wfds_intel_linux_dv
intel_linux_dv : setup $(obj_serial)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_serial)

# *** Intel MPI + Intel Fortran Linux ***

impi_intel_linux : FFLAGS = -O2 -ipo -no-wrap-margin
impi_intel_linux : CFLAGS = -O -Dpp_noappend
impi_intel_linux : FCOMPL = mpiifx
impi_intel_linux : CCOMPL = icx
impi_intel_linux : LFLAGS = -static-intel
impi_intel_linux : obj = wfds_impi_intel_linux
impi_intel_linux : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

impi_intel_linux_db : FFLAGS = -check all -warn unused -O0 -auto -WB -traceback -g -fpe0 -no-wrap-margin
impi_intel_linux_db : CFLAGS = -g -Dpp_noappend
impi_intel_linux_db : FCOMPL = mpiifx
impi_intel_linux_db : CCOMPL = icx
impi_intel_linux_db : LFLAGS = -static-intel
impi_intel_linux_db : obj = wfds_impi_intel_linux_db
impi_intel_linux_db : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

impi_intel_linux_dv : FFLAGS = -warn unused -O1 -g -traceback -no-wrap-margin
impi_intel_linux_dv : CFLAGS = -O1 -g -Dpp_noappend
impi_intel_linux_dv : FCOMPL = mpiifx
impi_intel_linux_dv : CCOMPL = icx
impi_intel_linux_dv : LFLAGS = -static-intel
impi_intel_linux_dv : obj = wfds_impi_intel_linux_dv
impi_intel_linux_dv : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

# *** OpenMPI + Intel Fortran Linux ***

ompi_intel_linux : FFLAGS = -O2 -ipo -no-wrap-margin
ompi_intel_linux : CFLAGS = -O -Dpp_noappend
ompi_intel_linux : FCOMPL = mpifort
ompi_intel_linux : CCOMPL = mpicc
ompi_intel_linux : LFLAGS = -static-intel
ompi_intel_linux : obj = wfds_ompi_intel_linux
ompi_intel_linux : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_intel_linux_db : FFLAGS = -check all -warn unused -O0 -auto -WB -traceback -g -fpe0 -no-wrap-margin
ompi_intel_linux_db : CFLAGS = -g -Dpp_noappend
ompi_intel_linux_db : FCOMPL = mpifort
ompi_intel_linux_db : CCOMPL = mpicc
ompi_intel_linux_db : LFLAGS = -static-intel
ompi_intel_linux_db : obj = wfds_ompi_intel_linux_db
ompi_intel_linux_db : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

ompi_intel_linux_dv : FFLAGS = -warn unused -O1 -g -traceback -no-wrap-margin
ompi_intel_linux_dv : CFLAGS = -O1 -g -Dpp_noappend
ompi_intel_linux_dv : FCOMPL = mpifort
ompi_intel_linux_dv : CCOMPL = mpicc
ompi_intel_linux_dv : LFLAGS = -static-intel
ompi_intel_linux_dv : obj = wfds_ompi_intel_linux_dv
ompi_intel_linux_dv : setup $(obj_mpi)
	$(FCOMPL) $(FFLAGS) $(LFLAGS) -o $(obj) $(obj_mpi)

# *** Object Dependencies ***

smvv.o : isob.o
cons.o : prec.o
mpis.o : prec.o
mpip.o : prec.o
type.o : prec.o cons.o
devc.o : prec.o
pois.o : prec.o cons.o
mesh.o : prec.o type.o
data.o : prec.o func.o cons.o
func.o : prec.o cons.o type.o mesh.o devc.o
ctrl.o : prec.o cons.o type.o mesh.o func.o
turb.o : func.o prec.o cons.o mesh.o
geom.o : func.o prec.o cons.o mesh.o
scrc.o : prec.o cons.o mesh.o func.o pois.o
irad.o : func.o prec.o cons.o type.o mesh.o
ieva.o : func.o prec.o cons.o type.o mesh.o
fire.o : func.o prec.o cons.o type.o mesh.o
hvac.o : func.o prec.o cons.o type.o mesh.o ctrl.o
wall.o : func.o prec.o cons.o type.o mesh.o hvac.o
velo.o : func.o prec.o cons.o type.o mesh.o turb.o geom.o
evac.o : func.o prec.o cons.o type.o mesh.o ieva.o data.o
divg.o : func.o prec.o cons.o type.o mesh.o scrc.o evac.o
mass.o : func.o prec.o cons.o type.o mesh.o turb.o
radi.o : func.o prec.o cons.o type.o mesh.o irad.o
pres.o : func.o prec.o cons.o type.o mesh.o pois.o velo.o scrc.o
part.o : func.o prec.o cons.o type.o mesh.o devc.o data.o
vege.o : func.o prec.o cons.o type.o mesh.o devc.o part.o
read.o : func.o prec.o cons.o type.o mesh.o devc.o ctrl.o irad.o evac.o hvac.o scrc.o data.o geom.o
init.o : func.o prec.o cons.o type.o mesh.o devc.o irad.o pois.o data.o evac.o
dump.o : func.o prec.o cons.o type.o mesh.o devc.o evac.o smvv.o isob.o turb.o scrc.o data.o
main.o : func.o prec.o cons.o type.o mesh.o devc.o smvv.o isob.o mass.o divg.o velo.o wall.o fire.o irad.o ieva.o radi.o evac.o part.o vege.o dump.o read.o init.o pres.o pois.o ctrl.o turb.o hvac.o scrc.o data.o geom.o

.PHONY : clean
clean:
	-rm -f *.o *.mod *.smod wfds_*
