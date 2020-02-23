% files = dir('s_*')
for i = 1:length(files)
    

    mkdir(files(i).name, 'dir')
    
    in = strcat('/deep/uddin/work/Lauren/dpabi/Task1/FunImgARWS/',files(i).name,'/denoised_new/denoised_func_data_nonaggr.nii.gz')
    out = strcat('/deep/uddin/work/Lauren/dpabi/Task1/ICA_Denoised/',files(i).name,'/denoised.nii.gz')
     %mkdir(files(i).name)
     copyfile(in,out)
end
     
