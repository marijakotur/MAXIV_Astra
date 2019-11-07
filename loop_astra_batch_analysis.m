%loop astra_batch_run_analysis

folderlist = dir;
for i=1:length(dir)
    if (isfolder(folderlist(i).name) & length(folderlist(i).name)>2)
        cd(folderlist(i).name)
        folderlist(i).name
        astra_batch_run_analysis
        cd ..
    end
end