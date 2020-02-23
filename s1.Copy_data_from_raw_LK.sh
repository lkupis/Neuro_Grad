#!/bin/bash

#Copy the subject's data into appropriate folder by parsing through the text file.
#Make sure to change the number of text for the s folders in lines that say cut -c 1-6 (may be more or less than 6 characters
#The script is also checking if the copied folder has the same # of volumes as in the RawData folder
# It will output "same" if the folders are the same size
#You can run multiple paradigms at the same time through the scrip. Even if there is not one of the paradigms in the subject's folder you can still run it because it will just echo that the paradigm doesn't exist 

# change  'cut -c 1-6' if needed

datadir=/deep/uddin/work/Lauren/dpabi
subjid=`cat $datadir/dpabi/Cog_Flex_Subject_IDs.txt`
#subjid="ACE_P12_02 F6J4M_01"


for subj in $subjid
do
	rootfolder=$datadir/RawData/$subj #where raw data exists
	echo $rootfolder
	destinationfolder=$datadir/YQ_data_analysis/data_process/$subj # where you want the data moved to
	echo $destinationfolder


	if [ ! -e $rootfolder/cfmricp_log_new.txt ]; then
		cp $rootfolder/cfmricp_log.txt $rootfolder/cfmricp_log_new.txt 
	fi
	echo $rootfolder/cfmricp_log_new.txt

	if [ -d "$destinationfolder" ] ; then 
		rm -r $destinationfolder 
	fi
	mkdir "$destinationfolder"

#cd 
	mkdir $destinationfolder/RawData
	cd $rootfolder

#Karen Lang
	
if [ ! -d $destinationfolder/RawData/Karen_Lang ]; then 

if grep -w "Karen_Lang" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Karen_Lang
	text=$(grep -w "Karen_Lang" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Karen_Lang/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Karen_Lang/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "Karen_Lang doesn't exist"
fi
fi

#Motherese
if [ ! -d $destinationfolder/RawData/Motherese ]; then 

if grep -w "Motherese" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Motherese 
	text=$(grep -w "Motherese" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Motherese/  #change e folder (original (e*))
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Motherese/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "Motherese doesn't exist"
fi
fi

#Motherese_NoSCN (it is the same as Motherese)
if [ ! -d $destinationfolder/RawData/Motherese ]; then 

if grep -w "Motherese_NoSCN" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Motherese 
	text=$(grep -w "Motherese_NoSCN" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Motherese/  #change e folder (original (e*))
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Motherese/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "Motherese doesn't exist"
fi
fi

#Motherese_SCN

if [ ! -d $destinationfolder/RawData/Motherese_SCN ]; then 

if grep -w "Motherese_SCN" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Motherese_SCN
	text=$(grep -w "Motherese_SCN" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Motherese_SCN/  #change e folder
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Motherese/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi 
else 
	echo "Motherese_SCN doesn't exist"
fi
fi

#Liz Lang
if [ ! -d $destinationfolder/RawData/Liz_Lang ]; then 

if grep -w "Liz_Lang" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Liz_Lang
	text=$(grep -w "Liz_Lang" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Liz_Lang/  #change e folder 
else 
	echo "Liz_Lang doesn't exist"
fi
fi

#Resting
if [ ! -d $destinationfolder/RawData/Resting ]; then

if grep -w "EPI 4echo Resting" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Resting
	text=$(grep -w "EPI 4echo Resting" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Resting/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Resting/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	 
else 
	echo "EPI 4echo Resting doesn't exist"
fi
fi

#FSPGR
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "FSPGR_ASSET_SAG_TI450" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "FSPGR_ASSET_SAG_TI450" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Structural/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "FSPGR_ASSET_SAG_TI450 doesn't exist"
fi
fi

#FSPGR
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "FSPGR" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "FSPGR" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Structural/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "FSPGR"
fi
fi


#FSPGR
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "FSPGR Sag_not_as_LongTR_T1" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "FSPGR Sag_not_as_LongTR_T1" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Structural/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "FSPGR Sag_not_as_LongTR_T1"
fi
fi

#FSPGR
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "Sag_not_as_LongTR_T1" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "Sag_not_as_LongTR_T1" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Structural/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "Sag_not_as_LongTR_T1"
fi
fi

#MPRAGE
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "PU:MPRAGE PROMO" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "PU:MPRAGE PROMO" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
else 
	echo "PU MPRAGE PROMO doesn't exist"
fi 
fi

#MPRAGE
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "PU:MPRAGE" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "PU:MPRAGE" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
else 
	echo "PU MPRAGE doesn't exist"
fi 
fi

#MPRAGE
if [ ! -d $destinationfolder/RawData/Structural ]; then

if grep -w "PU:MPRAGE" cfmricp_log_new.txt ; then
	mkdir $destinationfolder/RawData/Structural
	text=$(grep -w "PU:MPRAGE" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Structural/  #change e folder 
else 
	echo "PU MPRAGE doesn't exist"
fi 
fi

#EPI topup fwd
if [ ! -d $destinationfolder/RawData/Topup/SE/Fwd ]; then

if grep -w "SE EPI topup fwd" cfmricp_log_new.txt ; then
	mkdir -p $destinationfolder/RawData/Topup/SE/Fwd
	text=$(grep -w "SE EPI topup fwd" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Topup/SE/Fwd/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Topup/SE/Fwd/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "SE EPI topup fwd doesn't exist"
fi
fi

#EPI Topup rvs
if [ ! -d $destinationfolder/RawData/Topup/SE/Rvs ]; then

if grep -w "SE EPI topup rvs" cfmricp_log_new.txt ; then
	mkdir -p $destinationfolder/RawData/Topup/SE/Rvs
	text=$(grep -w "SE EPI topup rvs" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Topup/SE/Rvs/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Topup/SE/Rvs/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "SE EPI topup rvs doesn't exist"
fi
fi



#TOPUP pe1
if [ ! -d $destinationfolder/RawData/Topup/4Echo ]; then

if grep -w "4echo TOPUP CV pe1" cfmricp_log_new.txt ; then
	mkdir -p $destinationfolder/RawData/Topup/4Echo
	text=$(grep -w "4echo TOPUP CV pe1" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Topup/4Echo/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Topup/4Echo/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "4echo TOPUP CV pe1 doesn't exist"
fi
fi

#pe0
if [ ! -d $destinationfolder/RawData/Topup/4Echo ]; then

if grep -w "TOPUP pe0" cfmricp_log_new.txt ; then
	mkdir -p $destinationfolder/RawData/Topup/4Echo
	text=$(grep -w "TOPUP pe0" cfmricp_log_new.txt)
	x=$(echo $text | cut -c 1-6)
	echo $text
	echo $x
	cp -a $rootfolder/e*/$x/. $destinationfolder/RawData/Topup/4Echo/  #change e folder 
	if diff $rootfolder/e*/$x/ $destinationfolder/RawData/Topup/4Echo/ >/dev/null ; then
		echo "same"
	else
		echo "different"
	fi	
else 
	echo "4echo TOPUP pe0 doesn't exist"
fi
fi

done
