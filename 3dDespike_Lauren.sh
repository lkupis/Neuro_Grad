echo "Reading folderlist list"
for f in $(</deep/uddin/work/Lauren/dpabi/Rest/copy_of_Subject_rest.txt)
#for f in $(</deep/uddin/work/In_House_Data/CogFlex/CogFlex_Results/test.txt)
do
	#echo $count	
	((count += 1))
        path=/deep/uddin/work/Lauren/dpabi/Rest/FunImg/$f #put name of task folder
	echo $path
	folder=$path
        fname=$folder/"$f"_rest.nii
        echo $fname
	cd $folder
	pwd
	
       	output=$folder/despike_"${f}"_rest.nii
        #echo $output
        3dDespike -ignore 0 -nomask -NEW -prefix $output $fname
	
	#done
    
done
