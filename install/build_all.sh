#! /bin/bash

set -e
set -x


mkdir usr && mkdir usr/local
export INSTDIR=$PWD/usr/local/

if [ ! -d libDDD ] ;
then
    git clone --depth=1 https://github.com/lip6/libDDD.git
    cd libDDD
    autoreconf -vfi
    ./configure --enable-nolto --prefix=$INSTDIR
    make -j && make install
    cd ..
fi

if [ ! -d gmp-6.1.2 ]
then
    wget --progress=dot:mega https://gmplib.org/download/gmp/gmp-6.1.2.tar.bz2 ; tar xjf gmp-6.1.2.tar.bz2 ; cd gmp-6.1.2 ; ./configure --enable-cxx --prefix=$INSTDIR ; make -j ; make install ; cd .. ;
fi

if [ ! -d libexpat-R_2_2_4 ]
then
wget --progress=dot:mega https://github.com/libexpat/libexpat/archive/R_2_2_4.tar.gz ; tar xzf R_2_2_4.tar.gz ; cd libexpat-R_2_2_4/expat/ ; ./buildconf.sh ; ./configure --prefix=$INSTDIR --without-xmlwf ; make -j ; make install ; cd ../.. ;     
fi

if [ ! -d libITS ] ;
then
    git clone --depth=1 https://github.com/lip6/libITS.git
    mv libITS/antlr.sh .
    bash ./antlr.sh
    cd libITS
    autoreconf -vfi
    ./configure --enable-nolto --prefix=$INSTDIR  --with-libexpat=$INSTDIR  --with-gmp=$INSTDIR --with-antlrc=$INSTDIR   --with-antlrjar=$INSTDIR/lib/antlr-3.4-complete.jar CPPFLAGS="-I$INSTDIR/include" LDFLAGS="-L$INSTDIR/lib" 
    make && make install
    cd ..
fi

if [ ! -d ITS-CTL ] ;
then
    git clone --depth=1 https://github.com/lip6/ITS-CTL.git
    cd ITS-CTL
    autoreconf -vfi
    ./configure --enable-nolto --prefix=$INSTDIR  --with-libexpat=$INSTDIR  --with-antlrc=$INSTDIR  CPPFLAGS="-I$INSTDIR/include -DITS_EXERCISE" LDFLAGS="-L$INSTDIR/lib" 
    make
    cd tests ; \rm *.data ; cp ../../tests.tgz . ; tar xzf tests.tgz ; cd ..
    cd ..
fi


cd ITS-CTL ; make ; cd tests/ ; ./run_all.sh 2>/dev/null | grep testFailed ; cd ../..

echo "First edit file : ITS-CTL/src/mc/operators.cpp"
echo "Test like this : cd ITS-CTL ; make ; cd tests/ ; ./run_all.sh 2>/dev/null | grep testFailed ; cd ../.."

